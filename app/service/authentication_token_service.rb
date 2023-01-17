class AuthenticationTokenService

  def checksum(content)
    # creates checksum based of the contents of an input array. checksum is used to manually verify that token is transmitted completely
    bin = ""
    content.each do |c|
      bin = bin + c.to_s
    end
    Digest::SHA2.hexdigest(bin)
  end

  def call (secret, algorithm, issuer, payload)
    # creates a generic jwt
    payload["iss"] = issuer.to_s
    return JWT.encode payload, secret, algorithm
  end

  class Refresh
    HMAC_SECRET = 'my$ecretK3y'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.call(user_id)
      begin
        # aud = user type oder sowas
        iat = Time.now.to_i
        sub = user_id.to_s
        exp = Time.now.to_i + 4 * 3600
        jti = jti(iat, ISSUER.to_s)
        checksum = checksum([ISSUER.to_s, sub, exp, jti, iat])
        if sub.present? && exp.present? && jti.present? && checksum.present? && iat.present? && (checksum == checksum([ISSUER.to_s, sub, exp, jti, iat]))
          payload = { sub: sub, exp: exp, jti: jti, checksum: checksum, iat: iat }
          return super.call(HMAC_SECRET, ALGORITHM_TYPE, ISSUER, payload)
        else
          return false
        end
      rescue
        return false
      end
    end

    def self.content(token)
      # TODO: Document errors with metadata in log

      bin = []
      begin
        decoded_token = JWT.decode(token, HMAC_SECRET, true, { verify_jti: proc { |jti| jti?(jti) }, iss: ISSUER, verify_iss: true, verify_iat: true, required_claims: ['iss', 'sub', 'exp', 'jti', 'checksum', 'iat'], algorithm: ALGORITHM_TYPE })
      rescue JWT::ExpiredSignature
        bin.push({
                   "error": "ERR_EXPIRED",
                   "description": "Attribute has expired"
                 })
      rescue JWT::InvalidIssuerError
        bin.push({
                   "error": "ERR_INVALID",
                   "description": "Attribute is malformed or unknown"
                 })
      rescue JWT::InvalidJtiError
        bin.push({
                   "error": "ERR_INVALID",
                   "description": "Attribute is malformed or unknown"
                 })
      rescue JWT::InvalidIatError
        bin.push({
                   "error": "ERR_INVALID",
                   "description": "Attribute is malformed or unknown"
                 })
      rescue JWT::MissingRequiredClaim
        bin.push({
                   "error": "ERR_BLANK",
                   "description": "A required Attribute is missing"
                 })
      rescue JWT::DecodeError
        bin.push({
                   "error": "ERR_INVALID",
                   "description": "Attribute is malformed or unknown"
                 })
      rescue
        bin.push({
                   "error": "ERR_SERVER",
                   "description": "Please try again later. If this error persists, we recommend to contact our support team."
                 })
      end
      if bin.empty?
        return decoded_token
      else
        errors = bin.uniq { |e| e.first }
        err500 = false
        err401 = false
        err400 = false
        errors.each do |e|
          if e == "ERR_SERVER"
            err500 = true
          elsif e == "ERR_BLANK"
            err400 = true
          elsif e == "ERR_EXPIRED" || "ERR_INVALID"
            err401 = true
          end
          if err500 || (!err400 && !err401 && !err500)
            status = 500
          elsif !err500 && err400
            status = 400
          elsif !err500 && !err400 && err401
            status = 401
          end
          return { "status": status, "token": errors }
        end
      end

      def self.forbidden?(token)
        # if token is forbidden forbidden? is true if token is allowed forbidden? is false
        jti = content(token)
        if !jti[0].nil? # if .content returns { "status": status, "token": errors } == nil, because {...}[0] == nil
          return !(jti?(jti[0]["jti"]))
        else
          return jti # error message from content
        end

        private

        def self.jti(iat, iss)
          # creates a unique token identifier (made for application in refresh tokens)
          Digest::MD5.hexdigest([iat.to_s, iss, HMAC_SECRET].join(':').to_s)
        end

        def self.jti?(jti)
          # checks whether a apecifc (refresh) token is blacklisted
          # if token identifier is found in blacklist .jti? is false (so token is blocked);
          # if token identifier isnt blacklisted .jti? is true
          if AuthBlacklist.find_by(token: jti).present?
            false
          else
            true
          end
        end

        def self.checksum?(token)
          # checks whether given checksum in a refresh token is correct. if so checksum? is true, else it is false
          token = content(token)[0]
          checksum = token["checksum"]
          bin = []
          token.each do |k, v|
            if k != "checksum"
              bin.push(v)
            end
          end
          testsum = checksum(bin)
          if testsum == checksum
            true
          else
            false
          end
        end
      end
    end
  end

  class Access
    HMAC_SECRET = 'my$ecretK3y'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.call(token)
      # aud = user type oder sowas
      unless AuthBlacklist.forbidden?(token)
        begin
          # aud = user type oder sowas
          sub = user_id.to_s
          exp = Time.now.to_i + 300
          checksum = checksum([ISSUER.to_s, sub, exp])
          if sub.present? && exp.present? && checksum.present? && (checksum == checksum([ISSUER.to_s, sub, exp]))
            payload = { sub: sub, exp: exp, checksum: checksum }
            return {"status": 200, "access": super.call(HMAC_SECRET, ALGORITHM_TYPE, ISSUER, payload)}
          else
            return {"status": 500, "token": token}
          end
        rescue
          return {"status": 500, "token": token}
        end
      else
        return {"status": 403, "token": token}
      end
    end
  end

end
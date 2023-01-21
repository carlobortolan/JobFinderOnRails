class AuthenticationTokenService
  def self.checksum(content)
    # creates checksum based of the contents of an input array. checksum is used to manually verify that token is transmitted completely
    bin = ""
    content.each do |v, k|
      bin = bin + k.to_s
    end
    Digest::SHA2.hexdigest(bin)
  end

  def self.checksum?(decoded_token)
    # checks whether given checksum in a refresh token is correct. if so checksum? is true, else it is false
    checksum = decoded_token[0]["checksum"]
    bin = {}
    decoded_token[0].each do |k, v|
      if k != "checksum"
        bin[k] = v
      end
    end
    testsum = checksum(bin)
    if testsum == checksum
      return true
    else
      raise AuthenticationTokenService::InvalidChecksum
    end
  end

  def self.call (secret, algorithm, issuer, payload)
    # creates a generic jwt
    payload["iss"] = issuer.to_s
    payload["checksum"] = checksum(payload)
    return JWT.encode payload, secret, algorithm
  end

  def self.user? (user_id)
    # checks whether user exists is active or user is blacklisted (sense of user blacklist, is to enable more specifc regulation of user rights vs. 0 or 1)
    if !User.find_by(id: user_id).present?
      raise User::MrNobody
    else
      user = User.find_by(id: user_id)
      if user.activity_status == 0
        raise User::Inactive
      elsif UserBlacklist.find_by(user_id: user.id).present?
        raise User::Blocked
      end
    end

  end

  # no generic encoding because of custom validations

  class Refresh
    HMAC_SECRET = 'yTcW3y9&t<=2cYn=Qt*nYyj!+aFv^LMw&o`@'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.encode(sub, exp, jti, iat)
      payload = {sub: sub, exp:exp, jti:jti, iat:iat}
      return AuthenticationTokenService.call(HMAC_SECRET, ALGORITHM_TYPE, ISSUER, payload)
    end
    def self.call(user_id, man_exp = nil)
      # allows to give manual set expiration time of the refresh token
      if user_id.class == Integer && user_id.positive?
        bin = []
        begin
          AuthenticationTokenService.user?(user_id)
          #Todo: aud = user type oder sowas
          iat = Time.now.to_i
          sub = user_id.to_s
          if man_exp.nil? || man_exp > 4 * 3600 #if manual time is give it has to be less than 4 hours
            exp = Time.now.to_i + 4 * 3600
          else
            exp = Time.now.to_i + man_exp
          end
          jti = jti(iat, ISSUER.to_s)
          encoded_token = encode(sub,exp,jti,iat)
          if AuthenticationTokenService::Refresh.content(encoded_token)["token"].nil?
            raise JWT::DecodeError
          end
        rescue User::MrNobody
          bin.push({
                     "error" => "ERR_UNKNOWN",
                     "description" => "Attribute does not exists"
                   })
        rescue User::Inactive
          bin.push({
                     "error" => "ERR_INACTIVE",
                     "description" => "Attribute must be activated"
                   })
        rescue User::Blocked
          bin.push({
                     "error" => "ERR_BLOCKED",
                     "description" => "Proceeding is restricted"
                   })
        rescue
          bin.push({
                     "error" => "ERR_SERVER",
                     "description" => "Try again later. If this error persists, we kindly ask you to contact our Support team."
                   })
        end
        if bin.empty?
          return { "token" => encoded_token }
        else
          errors = bin.uniq { |e| e.first }
          err500 = false
          err403 = false
          err400 = false
          errors.each do |e|
            if e.to_s == "ERR_SERVER"
              err500 = true
            elsif e.to_s == "ERR_UNKNOWN"
              err400 = true
            elsif e.to_s == "ERR_BLOCKED" || "ERR_INACTIVE"
              err403 = true
            end
            if err500 || (!err400 && !err403 && !err500)
              status = 500
            elsif !err500 && err400
              status = 400
            elsif !err500 && !err400 && err403
              status = 403
            end
            return { "error" => { "status" => status, "errors" => { "user" => errors } } }
          end
        end
      else
        raise AuthenticationTokenService::InvalidInput
      end

    end
    def self.decode(token) # this method decodes a jwt token
      decoded_token = JWT.decode(token, HMAC_SECRET, true, { verify_jti: proc { |jti| jti?(jti) }, iss: ISSUER, verify_iss: true, verify_iat: true, required_claims: ['iss', 'sub', 'exp', 'jti', 'checksum', 'iat'], algorithm: ALGORITHM_TYPE })
      chsm = AuthenticationTokenService.checksum?(decoded_token)
      return decoded_token
    end

    def self.content(token) # this method decodes a jwt token and catches exceptions
      # TODO: Document errors with metadata in log
      bin = []
      begin
        decoded_token = decode(token)
      rescue JWT::ExpiredSignature
        puts "expired signature"
        bin.push({
                   "error" => "ERR_EXPIRED",
                   "description" => "Attribute has expired"
                 })
      rescue JWT::InvalidIssuerError
        puts "Invalid issuer"
        bin.push({
                   "error" => "ERR_INVALID",
                   "description" => "Attribute is malformed or unknown"
                 })
      rescue JWT::InvalidJtiError
        puts "invalid jti"
        bin.push({
                   "error" => "ERR_INVALID",
                   "description" => "Attribute is malformed or unknown"
                 })
      rescue JWT::InvalidIatError
        puts "invalid iat"
        bin.push({
                   "error" => "ERR_INVALID",
                   "description" => "Attribute is malformed or unknown"
                 })
      rescue JWT::MissingRequiredClaim
        puts "required claim is missing"
        bin.push({
                   "error" => "ERR_BLANK",
                   "description" => "A required Attribute is missing"
                 })
      rescue JWT::DecodeError
        puts "error while decoding"
        bin.push({
                   "error" => "ERR_INVALID",
                   "description" => "Attribute is malformed or unknown"
                 })
      rescue AuthenticationTokenService::InvalidChecksum
        puts "checksum mismatch"
        bin.push({
                   "error" => "ERR_INVALID",
                   "description" => "Attribute is malformed or unknown"
                 })
        # rescue
        # bin.push({
        #          "error" => "ERR_SERVER",
        #          "description" => "Please try again later. If this error persists, we recommend to contact our support team."
        #        })
      end
      if bin.empty? #no exceptions catched
        return { "token" => decoded_token[0] }
      else #exceptions catched
        errors = bin.uniq { |e| e.first } #throw out identical errors (e.g. 3x "ERR_INVALID" -> 1x "ERR_INVALID")
        # http status prioritization
        err500 = false
        err401 = false
        err400 = false
        errors.each do |e| #map error to error code
          if e.to_s == "ERR_SERVER"
            err500 = true
          elsif e.to_s == "ERR_BLANK"
            err400 = true
          elsif e.to_s == "ERR_EXPIRED" || "ERR_INVALID"
            err401 = true
          end

          if err500 || (!err400 && !err401 && !err500) #decide on http status for api
            status = 500
          elsif !err500 && err400
            status = 400
          elsif !err500 && !err400 && err401
            status = 401
          end
          return { "error" => { "status" => status, "errors" => { "token" => errors } } } #return error(s)
        end
      end
    end

    def self.forbidden?(token)
      # if token is forbidden .forbidden? is true if token is allowed .forbidden? is false
      jti = content(token)
      if !jti[0].nil? # if .content returns { "status": status, "token": errors } == nil, because {...}[0] == nil
        return !(jti?(jti[0]["jti"])) #if .jti? finds token identifier blacklisted, it returns true. .forbidden? returns false in this case
      else
        return jti # error message from content
      end
    end

    def self.jti(iat, iss)
      # creates a unique token identifier (made for application in refresh tokens)
      Digest::MD5.hexdigest([iat.to_s, iss, HMAC_SECRET].join(':').to_s)
    end

    def self.jti?(jti)
      # checks whether a specifc (refresh) token is blacklisted (via its identifier "jti")

      if AuthBlacklist.find_by(token: jti).present?
        false # user is blacklisted
      else
        true # user isn't blacklisted
      end
    end

    # TODO: Remove?
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

  class Access
    HMAC_SECRET = 'e&iZY9=k!D'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.call(token)
      # aud = user type oder sowas
      unless AuthBlacklist.forbidden?(token)
        begin
          # aud = user type oder sowas
          sub = user_id.to_s
          exp = Time.now.to_i + 300
          if sub.present? && exp.present?
            payload = { sub: sub, exp: exp }
            return { "status": 200, "access": AuthenticationTokenService.call(HMAC_SECRET, ALGORITHM_TYPE, ISSUER, payload) }
          else
            return { "status": 500, "token": token }
          end
        rescue
          return { "status": 500, "token": token }
        end
      else
        return { "status": 403, "token": token }
      end
    end
  end

  class InvalidChecksum < StandardError
  end
  class InvalidInput < StandardError
  end

end
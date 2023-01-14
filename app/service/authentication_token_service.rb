class AuthenticationTokenService
  class Refresh
    HMAC_SECRET = 'my$ecretK3y'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.call(user_id)
      # aud = user type oder sowas
      iss = ISSUER.to_s
      iat = Time.now.to_i
      sub = user_id.to_s
      exp = Time.now.to_i + 4 * 3600
      jti = jti(iat, iss)
      checksum = checksum([iss, sub, exp, jti, iat])
      if iss.present? && sub.present? && exp.present? && jti.present? && checksum.present? && (checksum == checksum([iss, sub, exp, jti, iat]))
        payload = { iss: iss, sub: sub, exp: exp, jti: jti, checksum: checksum, iat: iat }
        JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
      else
      end
    end

    def self.content(token)
      JWT.decode(token, HMAC_SECRET, true, { verify_jti: proc { |jti| jti?(jti)}, iss: ISSUER, verify_iss: true, verify_iat: true, required_claims: ['iss', 'sub', 'exp', 'jti', 'checksum', 'iat'], algorithm: ALGORITHM_TYPE })
    end

    def self.forbidden?(token)
      if AuthBlacklist.find_by(token: token).present?
        false
      else
        true
      end
    end

    def self.read(token)
     content(token)[0]
    end

    def self.checksum(content)
      bin = ""
      content.each do |c|
        bin = bin + c.to_s
      end
      Digest::SHA2.hexdigest(bin)
    end

    def self.checksum?(token)
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

    private

    def self.jti(iat, iss)
      Digest::MD5.hexdigest([iat.to_s, iss, HMAC_SECRET].join(':').to_s)
    end

    def self.jti?(jti)
      if AuthBlacklist.find_by(token: jti).present?
        false
      else
        true
      end
    end
  end
  class Access

  end


end

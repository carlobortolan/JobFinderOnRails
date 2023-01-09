class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(issuer, user_id, expires_at)
    iss = issuer.to_s
    sub = user_id.to_s
    exp = Time.parse(expires_at).to_i.to_s
    jti = Time.now.to_i.to_s
    checksum = checksum([iss,sub,exp,jti])
    if iss.present? && sub.present? && exp.present? && jti.present? && checksum.present? && (checksum == checksum([iss,sub,exp,jti]))
      payload = { iss: iss, "sub" => sub, "exp": Time.parse(expires_at).to_i, "jti": jti, "checksum": checksum }
      JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    else
    end
  end

  def self.content(token)
    puts "TOKEN"
    puts JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE })
    JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE })
  end

  def self.exists?(token)
    if Authentication.find_by(token: token).present?
      true
    else
      false
    end
  end
  def self.valid?(token)
      decode_token = content(token)[0]
      auth = Authentication.find_by(token: token)
      if auth.expires_at.to_i >= decode_token["exp"].to_i
        true
      else
        false
      end
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
    token.each do |k,v|
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

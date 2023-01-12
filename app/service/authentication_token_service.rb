class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(issuer, user_id)
    iss = issuer.to_s
    sub = user_id.to_s
    exp = Time.now.to_i + 4 * 3600
    jti = Digest::MD5.hexdigest([Time.now.to_i.to_s, iss, HMAC_SECRET].join(':').to_s)
    checksum = checksum([iss, sub, exp, jti])
    if iss.present? && sub.present? && exp.present? && jti.present? && checksum.present? && (checksum == checksum([iss, sub, exp, jti]))
      payload = { iss: iss, "sub" => sub, "exp": exp, "jti": jti, "checksum": checksum }
      JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    else
    end
  end

  def self.content(token)
    #JWT.decode(token, HMAC_SECRET, true, { verify_expiration: false, algorithm: ALGORITHM_TYPE })
    JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE })
  end

  def self.exists?(token)
    if Authentication.find_by(token: token).present?
      true
    else
      false
    end
  end

  def self.fresh?(token)
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

class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'
  def self.call(issuer, user_id, expires_at)
    seed = Time.now.to_i.to_s
    payload = {iss: issuer, "sub" => user_id, "exp": Time.parse(expires_at).to_i, "jti":seed , "checksum":Digest::SHA2.hexdigest(issuer+user_id.to_s+Time.parse(expires_at).to_i.to_s+seed)}
    JWT.encode payload, HMAC_SECRET,ALGORITHM_TYPE
  end
end

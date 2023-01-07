class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'
  def self.call(user_id, expires_at)
    seed = Time.now.to_i.to_s
    payload = {"user_id" => user_id, "expires_at": expires_at, "seed":seed , "checksum":Digest::SHA2.hexdigest(user_id.to_s+expires_at+seed)}
    JWT.encode payload, HMAC_SECRET,ALGORITHM_TYPE
  end
end

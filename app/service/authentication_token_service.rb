class AuthenticationTokenService

  # Todo: include some scope variable for handlesing different waccess rights in access token
  def self.call (secret, algorithm, issuer, payload)
    # generates a generic token (=> is used to generate refresh and access token)
    # CAUTION: NO INPUT VERIFICATION ETC. PROVIDED BY THIS METHOD
    payload["iss"] = issuer.to_s
    return JWT.encode payload, secret, algorithm
  end

  #########################################################
  ############### En-/Decoding Refresh token ##############
  #########################################################
  class Refresh
    HMAC_SECRET = 'yTcW3y9&t<=2cYn=Qt*nYyj!+aFv^LMw&o`@'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

    def self.encode(sub, exp, jti, iat)
      # serializes token generation for a refresh token
      payload = { sub: sub, exp: exp, jti: jti, iat: iat }
      return AuthenticationTokenService.call(HMAC_SECRET, ALGORITHM_TYPE, ISSUER, payload)
    end

    def self.decode(token)
      # token decoding for a refresh token
      # this method decodes a jwt token
      decoded_token = JWT.decode(token, HMAC_SECRET, true, { verify_jti: Proc.new { |jti| jti?(jti) }, iss: ISSUER, verify_iss: true, verify_iat: true, required_claims: ['iss', 'sub', 'exp', 'jti', 'iat'], algorithm: ALGORITHM_TYPE })
      if User.find_by(id:decoded_token[0]["sub"]).blank?
        raise JWT::InvalidSubError
      end
      return decoded_token
    end

    def self.forbidden?(token)
      # if exists and is explicitly blacklisted .forbidden? is true if token is allowed .forbidden? is false
      jti = content(token)
      if !jti[0].nil? # if .content returns { "status": status, "token": errors } == nil, because {...}[0] == nil
        return !(jti?(jti[0]["jti"])) # if .jti? finds token identifier blacklisted, it returns true. .forbidden? returns false in this case
      else
        return jti # error message from content
      end
    end

    def self.jti(iat)
      # creates a unique token identifier (made for application in refresh tokens)
      Digest::MD5.hexdigest([iat.to_s, ISSUER, HMAC_SECRET].join(':').to_s)
    end

    def self.jti?(jti)
      # checks whether a specifc (refresh) token is blacklisted (via its identifier "jti")

      if AuthBlacklist.find_by(token: jti).present?
        false # user is blacklisted
      else
        true # user isn't blacklisted
      end
    end
#TODO: ISSUE #25
=begin
    def self.sub?(sub)
      # checks whether a user exists in the database
      if User.find_by(id: sub.to_i).present?
        true # user is known
      else
        false # user is unknown
      end
    end
=end
    class Encoder # helper class for token generation
      MAX_INTERVAL = 86400 # == 24 hours
      MIN_INTERVAL = 1800 # == 0.5 hours == 30 min
      def self.call(user_id, man_interval = nil)
        if user_id.class != Integer || !user_id.positive? # is user_id parameter not an integer?
          raise AuthenticationTokenService::InvalidInput

        elsif User.find_by(id: user_id).blank? # is the given id referencing an non-existing user?
          raise AuthenticationTokenService::InvalidUser::Unknown

        elsif User.find_by(id: user_id).activity_status == 0 # is the user for the given id deactivated?
          raise AuthenticationTokenService::InvalidUser::Inactive::NotVerified

        elsif UserBlacklist.find_by(user_id: user_id).present? # is the user for the given id blacklisted/actively blocked?
          raise AuthenticationTokenService::InvalidUser::Inactive::Blocked

        else
          # the given id references an existing user, who is active and not blacklisted
          iat = Time.now.to_i # timestamp
          sub = user_id # who "owns" the token

          if man_interval.nil? # the man_interval parameter is not given/used
            bin_exp = iat + 14400 # standard validity interval (4 hours == 240 min == 14400 sec)

          else
            # the man_interval parameter is given/user -> a manual token expiration time is required
            if man_interval.class == Integer && man_interval.positive? # is man_interval a positive integer?

              if man_interval <= MAX_INTERVAL && man_interval >= MIN_INTERVAL # is the given required validity interval not longer than MAX_INTERVAL and not shorter than MIN_INTERVAL?
                bin_exp = iat + man_interval # the given required validity interval is sufficient

              elsif man_interval > MAX_INTERVAL # the given required validity interval is too long, so the token validity interval gets set to MAX_INTERVAL
                bin_exp = iat + MAX_INTERVAL

              elsif man_interval < MIN_INTERVAL # the given required validity interval is too short, so the token validity interval gets set to MIN_INTERVAL
                bin_exp = iat + MIN_INTERVAL
              end

            else
              # man_interval is no integer or either negative or 0
              raise AuthenticationTokenService::InvalidInput

            end
          end
          exp = bin_exp # placeholder for a standard value or a manually set value
          jti = AuthenticationTokenService::Refresh.jti(iat) # unique token identifier based on the issuing time and the issuer (more info above)
          return AuthenticationTokenService::Refresh.encode(sub, exp, jti, iat) # make a refresh token

        end
      end
    end

    class Decoder
      def self.call(token)
        if token.class != String || token.blank? # rhough check wether
          raise AuthenticationTokenService::InvalidInput

        else
          return AuthenticationTokenService::Refresh.decode(token)

        end
      end
    end
  end

  #########################################################
  ############### En-/Decoding Access token ###############
  #########################################################

  class Access
    HMAC_SECRET = 'e&iZY9=k!D'
    ALGORITHM_TYPE = 'HS256'
    ISSUER = Socket.gethostname

  end

  #########################################################
  ################# CUSTOM EXCEPTIONS #####################
  #########################################################

  class InvalidInput < StandardError
  end

  class InvalidUser < StandardError
    class Unknown < StandardError
    end

    class Inactive < StandardError
      class NotVerified < StandardError
      end

      class Blocked < StandardError
      end
    end

  end

end
module Api
  module V0
    class AuthenticationsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        #Todo: Implement Error + invalid call
        #Todo: Update Doc
        #Todo: An Registraton verify anbinden (abhängig von user_type scope festlegen etc.)
        #Todo: token checker an blacklist approach anpassen

        if user.activity_status == 1 && user.authenticate(token_params["password"]) && !UserBlacklist.find_by(user_id: user.id).present?
          issuer = Socket.gethostname
          token = AuthenticationTokenService.call(issuer, user.id)
          if AuthenticationTokenService.checksum?(token) && !AuthBlacklist.find_by(token: token).present?
            render status: 200, json: { "token": token }
          elsif AuthenticationTokenService.checksum?(token) &&AuthBlacklist.find_by(token: token).present?
            redirect_to create
          else
            render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
          end

          #@auth = Authentication.new(token: token, scope: scope, user: user.id, expires_at: expires_at, issuer: issuer)
          #if @auth.save
          #
          #else
          #  render status: 400, json: @auth.errors.details
          #end

        elsif (user.activity_status == 0 && user.authenticate(token_params["password"])) || (UserBlacklist.find_by(user_id: user.id).present? && user.authenticate(token_params["password"]))
          render status: 403, json: { "system": [
            {
              "error": "ERR_BLOCKED",
              "description": "Proceeding is restricted"
            }
          ]
          }
        else
          render status: 401, json: { "password": [
            {
              "error": "ERR_INVALID",
              "description": "Attribute is malformed or unknown"
            }
          ]
          }
        end
      end

      def verify
        # begin
        #if AuthenticationTokenService.checksum?(verify_params)
        #  if AuthenticationTokenService.exists?(verify_params)
        #    if AuthenticationTokenService.fresh?(verify_params)
        #     #render status: 200, json: { "token": true, "user": User.find_by(id: Authentication.find_by(token: verify_params).user.to_i) }
        #   else
        #     render status: 401, json: { "token": [
        #       {
        #         "error": "ERR_EXPIRED",
        #         "description": "Attribute has expired"
        #       }
        #     ]
        #     }
        #   end
        # else
        #   render status: 401, json: { "token": [
        #     {
        #       "error": "ERR_INVALID",
        #       "description": "Attribute is malformed or unknown"
        #     }
        #   ]
        #   }
        # end
        #else
        # render status: 401, json: { "token": [
        #   {
        #     "error": "ERR_INVALID",
        #     "description": "Attribute is malformed or unknown"
        #   }
        # ]
        # }
        #end
        #end
        #rescue JWT::ExpiredSignature
        #render status: 401, json: { "token": [
        #  {
        #   "error": "ERR_EXPIRED",
        #   "description": "Attribute has expired"
        # }
        #]
        #}
        #rescue JWT::InvalidIssuerError
        #render status: 401, json: { "token": [
        # {
        #   "error": "ERR_INVALID",
        #   "description": "Attribute is malformed or unknown"
        # }
        #]
        #}
        #rescue
        #render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
        end


      private

      def user
        @user ||= User.find_by(email: token_params["email"])
      end

      def token_params
        params.require(:token).permit(:email, :password)
      end

      def verify_params
        params.require(:token)
      end

    end

  end

end





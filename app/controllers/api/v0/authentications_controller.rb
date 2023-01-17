module Api
  module V0
    class AuthenticationsController < ApplicationController
      # Controller for refresh token
      protect_from_forgery with: :null_session
      def create
        # Todo: Implement Error handling for errors dropped while call
        # Todo: Update Doc
        # Todo: An Registraton verify anbinden (abhängig von user_type scope festlegen etc.)
        # Todo: implement refreshtoken & accesstoken approach

        if user.activity_status == 1 && user.authenticate(token_params["password"]) && !UserBlacklist.find_by(user_id: user.id).present?
          token = AuthenticationTokenService::Refresh.call(user.id)
          if AuthenticationTokenService::Refresh.checksum?(token) && !AuthBlacklist.find_by(token: token).present?
            render status: 200, json: { "token": token }
          else
            render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
          end

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
        ##
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





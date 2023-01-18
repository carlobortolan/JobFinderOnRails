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

        if user.activity_status == 1 && user.authenticate(token_params["password"]) && !(UserBlacklist.find_by(user_id: user.id).present?)
          puts true
          token = AuthenticationTokenService::Refresh.call(user.id)
          if token != false && !(AuthBlacklist.find_by(token: token).present?)
            render status: 200, json: { "token": token }
          else
            puts false
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
        puts "TOKEN"
        p token
        if !token["token"].nil?
          # scope ausgeben
          sub_id = token["token"][0]["sub"]
          sub = User.find_by(id: sub_id)
          if sub_id.present? && sub.present?
            render status: 200, json: { "token": { "user": sub.id } }
          else
            render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
          end
        elsif !token["error"].nil?
          render status: token["error"]["status"].to_i, json: token["error"]["errors"]
        else
          render status: 500, json: { "system": [
            {
              "error": "ERR_CRAZY",
              "description": "Note exactly what you did before this error occurred and contact our support team."
            }
          ]
          }
        end
      end

      private

      def user
        # enables to not explicitly define user by just calling this method
        @user ||= User.find_by(email: token_params["email"])
      end

      def token
        @token ||= AuthenticationTokenService::Refresh.content(verify_params)
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





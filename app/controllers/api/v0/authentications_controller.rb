module Api
  module V0
    class AuthenticationsController < ApplicationController
      # Controller for refresh token
      protect_from_forgery with: :null_session

      class Refresh
        def create
          if user.present?

            if user.authenticate(token_params["password"])
              begin
                # ============ Token gets claimed ==============
                if token_params["validity"].present? # is a custom token validity interval requested
                  token = AuthenticationTokenService::Refresh::Encoder.call(user.id, token_params["validity"])
                else
                  token = AuthenticationTokenService::Refresh::Encoder.call(user.id)[0]
                end
                render status: 200, json: { "refresh_token" => token }

                # ========== Rescue normal Exceptions ==========
              rescue AuthenticationTokenService::InvalidUser::Inactive::Blocked
                # The requested token subject (User) is blocked (blacklisted).
                render status: 403, json: { "user": [
                  {
                    "error": "ERR_INACTIVE",
                    "description": "Attribute is blocked."
                  }
                ]
                }

              rescue AuthenticationTokenService::InvalidUser::Inactive::NotVerified
                # The requested token subject (User) is unverified.
                render status: 403, json: { "user": [
                  {
                    "error": "ERR_INACTIVE",
                    "description": "Attribute is not verified."
                  }
                ]
                }

              rescue AuthenticationTokenService::InvalidInput::CustomEXP
                # Invalid Input (Validity [man_interval] attribute is malformed)
                render status: 400, json: { "validity": [
                  {
                    "error": "ERR_INVALID",
                    "description": "Attribute is malformed or unknown."
                  }
                ]
                }

                # ========== Rescue severe Exceptions ==========
              rescue AuthenticationTokenService::InvalidUser::Unknown
                # The requested token subject (User) doesn't exists BUT user.authenticate(token_params["password"]) says true
                render status: 500, json: { "user": [
                  {
                    "error": "ERR_SERVER",
                    "description": "Please try again later. If this error persists please contact the support team."
                  }
                ]
                }

              rescue AuthenticationTokenService::InvalidInput::SUB
                # Invalid Input (User Attribute is malformed) BUT user.authenticate(token_params["password"]) says true
                render status: 500, json: { "user": [
                  {
                    "error": "ERR_SERVER",
                    "description": "Please try again later. If this error persists please contact the support team."
                  }
                ]
                }

              end
            else # user.authenticate(token_params["password"]) fails
              render status: 401, json: { "password": [
                {
                  "error": "ERR_INVALID",
                  "description": "Attribute is malformed or unknown."
                }
              ]
              }
            end
          else # User.find_by(email: token_params["email"]) fails
            render status: 400, json: { "user": [
              {
                "error": "ERR_INVALID",
                "description": "Attribute is malformed or unknown."
              }
            ]
            }
          end
        end

        private

        def token_params
          #params.require(:token).permit(:email, :password)
          params.fetch(:refresh_token).permit(:email, :password, :validity)
        end

        def user
          # enables to not explicitly define user by just calling this method
          @user ||= User.find_by(email: token_params["email"])
        end
      end

      class Access

      end

    end

  end
end

=begin
      def create
        # Todo: Implement Error handling for errors dropped while call
        # Todo: Update Doc
        # Todo: An Registraton verify anbinden (abhängig von user_type scope festlegen etc.)
        # Todo: implement refreshtoken & accesstoken approach

        if user.authenticate(token_params["password"])
          token = AuthenticationTokenService::Refresh.call(user.id)
          if !token["token"].nil?
            render status: 200, json: { "token": token["token"] }
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

        else !user.authenticate(token_params["password"])
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
=end
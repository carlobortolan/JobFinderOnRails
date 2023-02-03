module Api
  module V0
    class RegistrationsController < ApplicationController
      protect_from_forgery with: :null_session
      #

      def index
        message = [{ statement: "Hello" }]
        render json: message
      end

      def create
        @user = User.new(user_params)
        begin
          if @user.save
            render status: 200, json: { "message": "Account registered! Please activate your account at GET http://localhost:3000/api/v0/user/verify " }

          else
            taken = false
            @user.errors.details[:email].each do |e|
              if e[:error] == "ERR_TAKEN"
                taken = true
              end
            end
            if taken
              render status: 422, json: { "error": @user.errors.details }
            else
              render status: 400, json: { "error": @user.errors.details }
            end
          end
        rescue
          render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
        end
      end

      def verify

        if params[:email].nil? && !params[:password].nil?
          render status: 400, json: { "email": [
            {
              "error": "ERR_BLANK",
              "description": "Attribute can't be blank"
            }
          ]
          }
        elsif !params[:email].nil? && params[:password].nil?
          render status: 400, json: { "password": [
            {
              "error": "ERR_BLANK",
              "description": "Attribute can't be blank"
            }
          ]
          }
        elsif params[:email].nil? && params[:password].nil?
          render status: 400, json: { "email": [
            {
              "error": "ERR_BLANK",
              "description": "Attribute can't be blank"
            }
          ], "password": [
            {
              "error": "ERR_BLANK",
              "description": "Attribute can't be blank"
            }
          ]
          }

        end

        if !params[:email].nil? && !params[:password].nil?
          user = User.find_by(email: params[:email])

          if !user.present?
            render status: 400, json: { "email": [
              {
                "error": "ERR_INVALID",
                "description": "Attribute is malformed or unknown"
              }
            ]
            }
          else
            begin
              if !user.authenticate(params[:password])
                render status: 401, json: { "password": [
                  {
                    "error": "ERR_INVALID",
                    "description": "Attribute is malformed or unknown"
                  }
                ]
                }
              else
                if user.activity_status == 1
                  render status: 403, json: { "system": [
                    {
                      "error": "ERR_BLOCKED",
                      "description": "Proceeding is restricted"
                    }
                  ]
                  }
                elsif user.activity_status == 0
                  user.update(activity_status: 1)
                  if !user.errors.empty?
                    raise
                  else
                    begin
                      token = AuthenticationTokenService::Refresh::Encoder.call(user.id)
                      render status: 200, json: { "refresh_token": token }
                    rescue
                      render status: 500, json: { "error": "Something went wrong while issuing your initial refresh token. Please try again later. If this error persists, we recommend to contact our support team." }
                    end
                  end

                end
              end

            rescue
              render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
            end
          end

        end

      end

      private

      def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
      end

      def checksum
        return Time.now.to_i + 360
      end

      def try_checksum(args)
        if (Time.now.to_i - args) > 0
          return false
        else
          return true
        end
      end

    end
  end
end


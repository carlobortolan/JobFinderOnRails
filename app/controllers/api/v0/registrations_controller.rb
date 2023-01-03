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
            render status: 422, json: { "error": @user.errors.details }
          end
        rescue
          render status: 500, json: { "error": "Please try again later. If this error persists, we recommend to contact our support team." }
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
      end
    end
  end
end


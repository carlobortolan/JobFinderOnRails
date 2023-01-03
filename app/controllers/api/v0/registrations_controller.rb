module Api
  module V0
    class RegistrationsController < ApplicationController
      protect_from_forgery with: :null_session
      # def index
      # render json: User.all
      # end


      def index
        message = [{ statement: "Hello" }]
        render json: message
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render status: 200, json: { message: "Account registered! Please activate your account at GET http://localhost:3000/api/v0/user/verify " }

        else
          render status: 422, json: @user.errors.details
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
      end
    end
  end
end


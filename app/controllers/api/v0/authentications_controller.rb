module Api
  module V0
    class AuthenticationsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        # Todo: Implement Error + invalid call
        # Todo: Update Doc
        # Todo: implement decoder
        # Todo: An Registraton verify anbinden

        if user.activity_status == 1 && user.authenticate(token_params["password"])
          expires_at = token_params["expires_at"]
          issuer = Socket.gethostname
          token = AuthenticationTokenService.call(issuer, user.id, expires_at)
          scope = 0
          @auth = Authentication.new(token: token, scope: scope, user: user.id, expires_at: expires_at, issuer: issuer)
          if @auth.save
            render status: 200, json: { "token": @auth.token }
          else
            render json: @auth.errors.details
          end

        else
          puts "FALS"
          puts user.activity_status == 1
          puts user.authenticate(token_params["password"])
          # puts @auth.errors.details
        end
      end

      def verify
        if AuthenticationTokenService.checksum?(verify_params)
          if AuthenticationTokenService.exists?(verify_params)
            if AuthenticationTokenService.valid?(verify_params)
              render status: 200, json: { "token": true, "user":User.find_by(id:Authentication.find_by(token: verify_params).user.to_i) }
            else
              # fehler
            end
          else
            # fehler
          end
        else
          # fehler
        end
      end

      private

      def user
        @user ||= User.find_by(email: token_params["email"])
      end

      def token_params
        params.require(:token).permit(:email, :password, :expires_at)
      end

      def verify_params
        params.require(:token)
      end

    end

  end

end





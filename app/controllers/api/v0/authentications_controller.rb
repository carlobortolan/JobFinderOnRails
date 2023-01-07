module Api
  module V0
    class AuthenticationsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        # Todo: Implement Error
        # Todo: Update Doc
        # Todo: implement decoder

        if user.activity_status == 1 && user.authenticate(token_params["password"])
          expires_at = token_params["expires_at"]
          issuer = Socket.gethostname
          token = AuthenticationTokenService.call(issuer, user.id, expires_at)
          scope = 0
          @auth = Authentication.new(token: token, scope: scope, user: user.id, expires_at: expires_at, issuer: issuer )
          if @auth.save
            render status: 200, json: { "token": @auth.token }
          else

          end

        else
          puts "FALS"
          puts user.activity_status == 1
          puts user.authenticate(token_params["password"])
          # puts @auth.errors.details
        end
      end

      private

      def user
        @user ||= User.find_by(email: token_params["email"])
      end

      def token_params
        params.require(:authentication).permit(:email, :password, :expires_at)
      end

    end

  end

end





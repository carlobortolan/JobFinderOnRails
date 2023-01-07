module Api
  module V0
    class AuthenticationsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        #Todo: Implement Mistakes and Updte Doc
        user = User.find_by(email: token_params["user"])
        if user.activity_status == 1
          token = ((0...50).map { ('a'..'z').to_a[rand(26)] }.join + (0...50).map { (0..9).to_a[rand(26)] }.join).split('').shuffle.join
          scope = 0
          checksum = Digest::SHA2.hexdigest token
          expires_at = token_params["expires_at"]
          puts "EA"
          p expires_at
          @auth = Authentication.new(user: user.id, token: token, scope: scope, checksum: checksum, expires_at: expires_at)
          if @auth.save
            render status: 200, json: {
              "auth_key": {
                "token": @auth.token,
                "checksum": @auth.checksum
              }

            }
          else
            puts "FALSE"
            puts @auth.errors.details
          end
        end
      end

      private

      def token_params
        params.require(:authentication).permit(:user, :expires_at)
      end
    end
  end
end



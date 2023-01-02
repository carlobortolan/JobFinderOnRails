module Api
  module V0
    class RegistrationsController < ApplicationController
      def index
        render json: User.all
      end

    end
  end
end


# frozen_string_literal: true

module Api
  module V0
    class JobsController < ApplicationController
      def index
        render json: Job.all
      end
    end
  end
end
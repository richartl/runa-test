module Api
  module V1
    class UserLogTypesController < ApplicationController

      def index
        user_log_types = UserLogType.all
        render json: user_log_types, status: 200
      end
    end
  end
end

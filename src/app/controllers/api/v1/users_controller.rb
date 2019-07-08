module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_request!
      before_action :check_index, only: :index

      def index
        users = User.all
        render json: users, status: 200
      end

      private
      def check_index
        fail Api::V1::RequestError.new(401, 'Unauthorized') unless current_user.has_role?(User::ADMIN_ROLE)
      end
    end
  end
end

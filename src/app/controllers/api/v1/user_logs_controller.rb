module Api
  module V1
    class UserLogsController < ApplicationController
      before_action :authenticate_request!
      before_action :validate_index, only: :index
      before_action :check_index, only: :index
      before_action :validate_create, only: :create
      before_action :check_create, only: :create

      def index
        user_logs = @user.user_logs
        render json: user_logs, status: 200
      end

      def create
        user_log = UserLog.new(
          employee: @user,
          admin: current_user,
          user_log_type: @user_log_type
        )
        fail Api::V1::RequestError.new(409, 'UserLog not saved') unless user_log.save
        render json: user_log, status: 201
      end

      private

      def index_params
        params.permit(:user_id)
      end

      def validate_index
        param! :user_id, Integer, required: true
      end

      def check_index
        @user = User.find_by_id_for_api(create_params[:user_id])
      end

      def create_params
        params.permit(:user_id, :user_log_type_id)
      end

      def validate_create
        param! :user_id, Integer, required: true
        param! :user_log_type_id, Integer, required: true
      end

      def check_create
        fail Api::V1::RequestError.new(401, 'Unauthorized') unless current_user.has_role?(User::ADMIN_ROLE)
        @user = User.find_by_id_for_api(create_params[:user_id])
        @user_log_type = UserLogType.find_by_id_for_api(create_params[:user_log_type_id])
      end
    end
  end
end

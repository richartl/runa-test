module Api
  module V1
    class AuthController < ApplicationController
      before_action :validate_auth, only: :authenticate_user
      before_action :check_auth, only: :authenticate_user

      def authenticate_user
        if @user.valid_password?(auth_params[:password])
          render json: @user, meta: {auth_token: JsonWebToken.encode({user_id: @user.id})}
        else
          fail Api::V1::RequestError.new(401, 'Unauthorized')
        end
      end

      private

      def auth_params
        params.permit(:email, :password)
      end

      def validate_auth
        param! :email, String, required: false, blank: false, format: /^.+@.+$/
        param! :password, String, required: false, blank: false
      end

      def check_auth
        @user = User.find_for_database_authentication(email: params[:email])
        fail Api::V1::RequestError.new(404, 'User Not found') if @user.nil?
      end
    end
  end
end

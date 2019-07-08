class ApplicationController < ActionController::API
  attr_reader :current_user
  def authenticate_user
    @current_user = User.find(auth_token[:user_id]) if auth_token
    !@current_user.nil?
  end

  def authenticate_request!
    fail Api::V1::RequestError.new(401, 'Unauthorized') unless authenticate_user
  end

  private
  def http_token
    @http_token ||= request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end

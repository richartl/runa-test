class UserLogType < ApplicationRecord
  include Swagger::Blocks
  validates :name , uniqueness: true, presence: true

  swagger_schema :UserLogType do
    property :id do
      key :type, :integer
    end
    property :name do
      key :type, :number
    end
    property :display_name do
      key :type, :string
    end
  end

  def self.find_by_id_for_api(user_log_type_id)
    user_log_type = UserLogType.find_by(id: user_log_type_id)
    fail Api::V1::RequestError.new(404, 'UserLogType not found') if user_log_type.nil?
    user_log_type
  end
end

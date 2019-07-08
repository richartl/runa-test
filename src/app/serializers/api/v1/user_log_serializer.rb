module Api
  module V1
    class UserLogSerializer < ActiveModel::Serializer
      attributes :id, :created_at
      has_one :employee
      has_one :admin
      has_one :user_log_type
    end
  end
end

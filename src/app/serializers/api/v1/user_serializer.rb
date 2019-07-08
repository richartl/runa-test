module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email
      has_many :roles
    end
  end
end

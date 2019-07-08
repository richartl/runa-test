module Api
  module V1
    class UserLogTypeSerializer < ActiveModel::Serializer
      attributes :id, :name, :description
    end
  end
end

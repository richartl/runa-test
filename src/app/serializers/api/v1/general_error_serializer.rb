module Api
  module V1
    class GeneralErrorSerializer < ActiveModel::Serializer
      type :error
      attributes :status, :message, :description, :id

      def id
        1
      end
    end
  end
end

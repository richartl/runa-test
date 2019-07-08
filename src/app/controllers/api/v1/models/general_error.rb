module Api
  module V1
    module Models
      class GeneralError
        include ActiveModel::Serialization
        include Swagger::Blocks

        attr_accessor :status, :message, :description

        swagger_schema :GeneralError do
          property :data do
            key :type, :object
            property :id do
              key :type, :integer
            end
            property :type do
              key :type, :string
            end
            property :attributes do
              key :type, :object
              property :status do
                key :type, :integer
              end
              property :message do
                key :type, :string
              end
              property :description do
                key :type, :string
              end
            end
          end
        end

        def initialize(status, description)
          self.status = status
          self.message = I18n.t("exceptions.code_#{status}")
          self.description = description
        end
      end
    end
  end
end

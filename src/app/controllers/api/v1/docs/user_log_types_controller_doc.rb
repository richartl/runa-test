module Api
  module V1
    module Docs
      class UserLogTypesControllerDoc
        include Swagger::Blocks

        swagger_schema :UserLogType do
          property :id do
            key :type, :integer
          end
          property :type do
            key :type, :string
          end
          property :atributes do
            key :type, :object
            property :name do
              key :type, :string
            end
            property :description do
              key :type, :string
            end
          end
        end

        swagger_path '/api/v1/user_log_types' do
          operation :get do
            key :summary, "Get user log types"
            key :produces, [
              'application/json'
            ]
            key :tags, [
              'user_log_types'
            ]

            response 200 do
              key :description, 'User Log created'
              schema do
                property :data do
                  key :type, :array
                  items do
                    key :'$ref', :UserLogType
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

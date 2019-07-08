module Api
  module V1
    module Docs
      class UsersControllerDoc
        include Swagger::Blocks

        swagger_schema :Role do
          property :id do
            key :type, :integer
          end
          property :name do
            key :type, :string
          end
          property :resource_type do
            key :type, :string
          end
          property :resource_id do
            key :type, :integer
          end
        end

        swagger_schema :User do
          property :id do
            key :type, :integer
          end
          property :type do
            key :type, :string
          end
          property :attributes do
            key :type, :object
            property :email do
              key :type, :string
            end
          end
          property :relationships do
            key :type, :object
            property :roles do
              property :data do
                key :type, :array
                items do
                  key :'$ref', :Role
                end
              end
            end
          end
        end

        swagger_path '/api/v1/users' do
          operation :get do
            key :summary, "Get user log types"
            key :produces, [
              'application/json'
            ]
            key :tags, [
              'users'
            ]

            security do
              key :Authorization, []
            end

            response 200 do
              key :description, 'Users list'
              schema do
                property :data do
                  key :type, :array
                  items do
                    key :'$ref', :User
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

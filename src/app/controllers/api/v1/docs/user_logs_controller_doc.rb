module Api
  module V1
    module Docs
      class UserLogsControllerDoc
        include Swagger::Blocks

        swagger_schema :CreateUserLog do
          key :required, %i[user_log_type_id]
          property :user_log_type_id do
            key :type, :integer
          end
        end

        swagger_path '/api/v1/users/{user_id}/user_logs' do
          operation :post do
            key :summary, "Create log for user"
            key :produces, [
              'application/json'
            ]
            key :tags, [
              'user_logs'
            ]

            security do
              key :Authorization, []
            end

            parameter do
              key :name, :user_id
              key :in, :path
              key :description, 'User id'
              key :required, true
              key :type, :integer
              key :example, '1'
            end

            parameter do
              key :name, :user
              key :in, :body
              key :description, 'Parameters for create user logs'
              key :required, true
              schema do
                key :'$ref', :CreateUserLog
              end
            end

            response 201 do
              key :description, 'User Log created'
              key :type, :object
              key :'$ref', :GeneralError
            end

            response 422 do
              key :description, 'Wrong parameters'
              schema do
                key :'$ref', :GeneralError
              end
            end

            response 404 do
              key :description, 'Not Found'
              schema do
                key :'$ref', :GeneralError
              end
            end

            response 401 do
              key :description, 'Unauthorized'
              schema do
                key :'$ref', :GeneralError
              end
            end
          end
        end

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

        swagger_path '/api/v1/users/{user_id}/user_logs' do
          operation :get do
            key :summary, "Get user log types"
            key :produces, [
              'application/json'
            ]
            key :tags, [
              'user_logs'
            ]

            security do
              key :Authorization, []
            end

            parameter do
              key :name, :user_id
              key :in, :path
              key :description, 'User id'
              key :required, true
              key :type, :integer
              key :example, '1'
            end

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

module Api
  module V1
    module Docs
      class AuthControllerDoc
        include Swagger::Blocks

        swagger_schema :UserLogin do
          key :required, %i[email password]
          property :email do
            key :type, :string
          end
          property :password do
            key :type, :string
          end
        end

        swagger_schema :UserLogged do
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
              property :email do
                key :type, :string
              end
            end
          end
          property :meta do
            key :type, :object
            property :auth_token do
              key :type, :string
            end
          end
        end

        swagger_path '/api/v1/login' do
          operation :post do
            key :summary, "Login for users"
            key :produces, [
              'application/json'
            ]
            key :tags, [
              'users'
            ]

            parameter do
              key :name, :user
              key :in, :body
              key :description, 'Parameters for login'
              key :required, true
              schema do
                key :'$ref', :UserLogin
              end
            end

            response 200 do
              key :description, 'User logged'
              key :type, :object
              key :'$ref', :UserLogged
            end

            response 422 do
              key :description, 'Wrong parameters'
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
      end
    end
  end
end

module Api
  module V1
    class DocController < ApplicationController
      include Swagger::Blocks

      swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Runa Test ApiV1'
          key :description, 'RoR API'
        end
        key :basePath, '/'
        key :consumes, ['application/json']
        key :produces, ['application/json']

        security_definition :Authorization do
          key :type, :apiKey
          key :name, :Authorization
          key :in, :header
        end
      end

      SWAGGERED_CLASSES = [
        Models::GeneralError,
        Docs::AuthControllerDoc,
        Docs::UserLogsControllerDoc,
        Docs::UserLogTypesControllerDoc,
        Docs::UsersControllerDoc,
        self
      ].freeze

      def index
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
      end
    end
  end
end

module Api
  module V1
    class ApplicationController < ::ApplicationController
      rescue_from(Api::V1::RequestError) do |error|
        errors = Api::V1::Models::GeneralError.new(error.code, error.description)
        render json: errors, serializer: Api::V1::GeneralErrorSerializer, status: error.code
      end

      rescue_from(RailsParam::Param::InvalidParameterError) do |error|
        errors = Api::V1::Models::GeneralError.new(422, error.message)
        render json: errors, serializer: Api::V1::GeneralErrorSerializer, status: 422
      end
    end
  end
end

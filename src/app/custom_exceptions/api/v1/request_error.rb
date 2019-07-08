module Api
  module V1
    class RequestError < StandardError
      attr_reader :code, :description

      def initialize(code, description)
        @code = code
        @description = description
      end
    end
  end
end

module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable

      rescue_from Pundit::NotAuthorizedError do |error|
        render json: error_structure(error), status: :forbidden
      end

      protected

      def error_structure(error)
        ErrorStructure.build(error)
      end

      def serialize(data)
        name = self.class.to_s.split('::').last.remove('Controller').singularize

        "#{name}Serializer".constantize.new(data)
      end
    end
  end
end

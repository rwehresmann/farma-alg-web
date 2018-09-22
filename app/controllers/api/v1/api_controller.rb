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
    end
  end
end

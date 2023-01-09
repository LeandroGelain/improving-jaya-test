require 'json'

module Errors
  class Unauthorized < StandardError
  end

  class CustomException < StandardError
    def initialize(message, status = 400)
      super({ 'message': message, 'status': status })
    end
  end

  module ErrorsHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
        rescue_from Errors::Unauthorized, with: :unauthorized_error
        rescue_from Errors::CustomException, with: :custom_exception_error
      end
    end

    private

    def not_found_error
      render json: {
        error: I18n.t('errors.messages.not_found')
      }, status: :not_found
    end

    def unauthorized_error
      render json: { error: I18n.t('errors.messages.not_authenticated') }, status: :unauthorized
    end

    def custom_exception_error(exception)
      object_error = exception.message.gsub(':', '"').gsub('=>', '":')
      parsed_object_error = JSON.parse(object_error)
      render json: {
        message: parsed_object_error['message']
      }, status: parsed_object_error['status']
    end
  end
end

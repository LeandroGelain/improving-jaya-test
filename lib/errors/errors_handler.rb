require 'json'

module Errors
  class Unauthorized < StandardError
  end

  module ErrorsHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
        rescue_from Errors::Unauthorized, with: :unauthorized_error
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
  end
end

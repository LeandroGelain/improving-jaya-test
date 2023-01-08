class ApplicationController < ActionController::Base
  include Errors::ErrorsHandler

  include WebhookAuthHelper
  include UserAuthHelper
end

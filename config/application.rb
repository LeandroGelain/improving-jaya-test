require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeveloperTestV2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.i18n.default_locale = :"pt-BR"
    config.autoload_paths << Rails.root.join('app/resources')
    # Configuration for the application, engines, and railties goes here.
    Rails.application.config.hosts<< '.sa.ngrok.io'

    config.eager_load_paths += Dir[Rails.root.join('app', 'models', '**', '*')]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.api_only = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths << "#{Rails.root}/lib" 
  end
end

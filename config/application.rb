require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.available_locales = %i(en vi)
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.middleware.use I18n::JS::Middleware

    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.autoload_paths << Rails.root.join('lib')
  end
end

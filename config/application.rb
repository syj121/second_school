require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SecondSchool
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.enabled = true

    #本地的cable默认只能跑在3000端口上，如果变更端口号，需要在application.rb中做如下配置
    config.action_cable.disable_request_forgery_protection = true

    #文件类
    config.autoload_paths += Dir["#{Rails.root}/app/uploaders/*"]

    #修改cache存储方式
    config.cache_store = :redis_store, {
      host: "localhost",
      port: 6379,
      db: 0,
      password: "",
      namespace: "second_school"
    }, {
      expires_in: 90.minutes
    }

  end
end

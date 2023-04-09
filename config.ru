# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

unless Rails.env.development?
  if defined?(Rails)
    ActiveSupport.on_load(:after_initialize) do
      Rpush.embed
    end
  else
    Rpush.embed
  end
end

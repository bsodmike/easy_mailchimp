module EasyMailchimp
  extend self

  def config
    yield(Configuration) if block_given?
    Configuration
  end

  module Configuration
    include ActiveSupport::Configurable

    config_accessor :api_endpoint,
      :api_version,
      :api_key,
      :logger

    self.api_version = "3.0"
    self.api_endpoint = "https://{{dc}}.api.mailchimp.com"
    self.logger = ::Logger.new(STDOUT)
  end
end


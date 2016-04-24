require "logger"
require "gibbon"
require "easy_mailchimp/version"
require "easy_mailchimp/configuration"

module EasyMailchimp
  autoload :Base, 'easy_mailchimp/base'
  autoload :Logger, 'easy_mailchimp/logger'
end

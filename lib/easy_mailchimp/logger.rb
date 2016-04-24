module EasyMailchimp
  class Logger
    def initialize(logger)
      @logger = logger
    end

    attr_reader :logger

    def info(message, tag = nil)
      if defined?(::Rails) && defined?(::ActiveSupport::Logger)
        if ::Rails.logger.class == ::ActiveSupport::Logger

          if tag.present?
            ::Rails.logger.tagged(tag) { ::Rails.logger.debug message }
          else
            ::Rails.logger.debug message
          end

          return

        end
      end

      logger.debug message
    end
  end
end


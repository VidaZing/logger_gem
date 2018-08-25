require 'vidazing_logger/version'
require 'vidazing_logger/appenders/stdout'
require 'vidazing_logger/appenders/stderr'

require 'logging'

# Namespace for the convenience method to create a new logger
#
# @see VidazingLogger#logger
# @since 0.1.0
module VidazingLogger
  class << self

    # [String]
    LOG_DIR = "logs"

    # Creates the 'logs/' directory
    def initialize
      Dir.mkdir(LOG_DIR) unless Dir.exists?(LOG_DIR)
    end

    # Deletes the 'logs/' directory
    def clean
      FileUtils.remove_dir(LOG_DIR, true)
    end

    # Create a Logger with 4 Appenders.
    # STDERR + 'logs/error.log'
    # STDOUT + 'logs/build.log'
    #
    # @param name [String] Logger name used in messages
    # @return [Logging.logger] See https://github.com/TwP/logging/blob/master/lib/logging/logger.rb
    def logger(name = 'VidaZing')
      VidazingLogger.initialize

      log = Logging.logger[name]
      log.add_appenders \
        VidazingLogger::Appenders::Stdout.stdout_appender,
        VidazingLogger::Appenders::Stdout.build_log_appender(LOG_DIR),
        VidazingLogger::Appenders::Stderr.stderr_appender,
        VidazingLogger::Appenders::Stderr.error_log_appender(LOG_DIR)

      log
    end
  end
end

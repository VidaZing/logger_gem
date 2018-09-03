# frozen_string_literal: true

require 'vidazing_logger/logger_builder'

# Namespace for the convenience method to create a new logger
#
# @see VidazingLogger#logger
# @since 0.1.0
module VidazingLogger
  class << self
    # [String]
    LOG_DIR = 'logs'

    # Creates the 'logs/' directory
    def initialize
      Dir.mkdir(LOG_DIR) unless Dir.exist?(LOG_DIR)
    end

    # Deletes the 'logs/' directory
    # @since 0.1.0
    def clean
      FileUtils.remove_dir(LOG_DIR, true)
    end

    # Create a Logger with 4 Appenders.
    # STDERR + 'logs/error.log'
    # STDOUT + 'logs/build.log'
    #
    # @param name [String] Logger name used in messages
    # @return [Logging.logger] See https://github.com/TwP/logging/blob/master/lib/logging/logger.rb
    # @since 0.1.0
    def logger(name = 'VidaZing')
      VidazingLogger.initialize

      LoggerBuilder.build(name: name) do |builder|
        builder
          .add_stdout
          .add_build_log(log_dir: LOG_DIR)
          .add_stderr
          .add_error_log(log_dir: LOG_DIR)
      end
    end
  end
end

# frozen_string_literal: true

require 'vidazing_logger/logger'

# Namespace for the convenience method to create a new logger
#
# @see VidazingLogger#logger
# @since 0.1.0
module VidazingLogger
  class << self
    # [String]
    LOG_DIR = 'logs'
    DEFAULT_LOGGER_NAME = 'VidaZing'

    # Deletes the 'logs/' directory
    #
    # @param log_dir [String] Directory to delete
    # @return nil
    # @since 0.1.0
    def clean(log_dir = LOG_DIR)
      @vidazing_logger = VidazingLogger::Logger.new \
        log_dir,
        name: DEFAULT_LOGGER_NAME

      @vidazing_logger.clean
    end

    # Create a Logger with 4 Appenders.
    # STDERR + 'logs/error.log'
    # STDOUT + 'logs/build.log'
    #
    # @param name [String] Logger name used in messages
    # @param log_dir [String] Directory to write logs in
    # @see VidazingLogger::Logger#build
    # @return [Logging.logger] See https://github.com/TwP/logging/blob/master/lib/logging/logger.rb
    # @since 0.2.0
    def logger(name = DEFAULT_LOGGER_NAME, log_dir = LOG_DIR)
      @vidazing_logger = VidazingLogger::Logger.new \
        log_dir,
        name: name

      @vidazing_logger.build
    end
  end
end

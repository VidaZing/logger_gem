# frozen_string_literal: true

require 'vidazing_logger/version'
require 'vidazing_logger/appenders/stdout'
require 'vidazing_logger/appenders/log/build'
require 'vidazing_logger/appenders/stderr'
require 'vidazing_logger/appenders/log/error'

require 'logging'

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

      stdout = VidazingLogger::Appenders::Stdout.new
      build_log = VidazingLogger::Appenders::BuildLog.new(log_dir: LOG_DIR)

      stderr = VidazingLogger::Appenders::Stderr.new
      error_log = VidazingLogger::Appenders::ErrorLog.new(log_dir: LOG_DIR)

      log = Logging.logger[name]
      log.add_appenders \
        stdout.appender,
        build_log.appender,
        stderr.appender,
        error_log.appender

      log
    end
  end
end

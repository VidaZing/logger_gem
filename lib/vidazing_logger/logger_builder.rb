# frozen_string_literal: true

require 'vidazing_logger/appenders/logging_gem_adapter'

require 'vidazing_logger/appenders/stdout'
require 'vidazing_logger/appenders/build_log'
require 'vidazing_logger/appenders/stderr'
require 'vidazing_logger/appenders/error_log'

require 'logging'

module VidazingLogger
  # Select where the logger will write to
  #
  # @see Logging.logger
  # @since 0.2.0
  class LoggerBuilder
    attr_reader :logger

    def self.build(name:)
      builder = new(name: name)
      yield(builder)
      builder.logger
    end

    def initialize(name:)
      # Create a logger before any appenders
      # Avoids a situation where Filters::Normal levels are nil
      #
      # Logging::Filters::Level.new bug:
      # @filter has nil levels set on the first invocation
      @logger = Logging.logger[name]
    end

    def add_stdout
      appender = Appenders::Stdout.new
      logging_appender_type = Appenders::Type::ID_STDOUT

      add_logging_appender(logging_appender_type, vidazing_appender: appender)
    end

    def add_stderr
      appender = Appenders::Stderr.new
      logging_appender_type = Appenders::Type::ID_STDERR

      add_logging_appender(logging_appender_type, vidazing_appender: appender)
    end

    def add_build_log(log_dir:)
      appender = Appenders::BuildLog.new(log_dir: log_dir)
      add_log(vidazing_appender: appender)
    end

    def add_error_log(log_dir:)
      appender = Appenders::ErrorLog.new(log_dir: log_dir)
      add_log(vidazing_appender: appender)
    end

    private

    def add_log(vidazing_appender:)
      logging_appender_type = Appenders::Type::ID_ROLLING_FILE

      add_logging_appender \
        logging_appender_type,
        vidazing_appender: vidazing_appender
    end

    def add_logging_appender(logging_appender_type, vidazing_appender:)
      # Using public_send since ruby methods are not first class
      adapter = Appenders::LoggingGemAdapter.public_send \
        logging_appender_type,
        vidazing_appender: vidazing_appender

      logging_appender = adapter.logging_appender
      @logger.add_appenders(logging_appender)

      self
    end
  end
end

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
  # @example Building a Logger
  #   LoggerBuilder.build(name: @name) do |builder|
  #     builder
  #       .add_stdout
  #       .add_build_log(log_dir: @log_dir)
  #       .add_stderr
  #       .add_error_log(log_dir: @log_dir)
  #
  # @see Logging.logger
  # @since 0.2.0
  class LoggerBuilder
    # The resulting builder logger object
    #
    # @return [Logging.logger]
    attr_reader :logger

    # Create a new LoggerBuilder
    #
    # @param name [String] Reference to obtain the logger.
    # @return [Logging.logger]
    def self.build(name:)
      builder = new(name: name)
      yield(builder)
      builder.logger
    end

    # Sets up the underlying Logging.logger reference.
    #
    # @param name [String] Reference to obtain the logger.
    def initialize(name:)
      # Create a logger before any appenders
      # Avoids a situation where Filters::Normal levels are nil
      #
      # Logging::Filters::Level.new bug:
      # @filter has nil levels set on the first invocation
      @logger = Logging.logger[name]
    end

    # Outputs log messages to STDOUT
    #
    # @return nil
    def add_stdout
      appender = Appenders::Stdout.new
      logging_appender_type = Appenders::Type::ID_STDOUT

      add_logging_appender(logging_appender_type, vidazing_appender: appender)
    end

    # Outputs log messages to STDERR
    #
    # @return nil
    def add_stderr
      appender = Appenders::Stderr.new
      logging_appender_type = Appenders::Type::ID_STDERR

      add_logging_appender(logging_appender_type, vidazing_appender: appender)
    end

    # Adds a VidazingLogger::Appender::BuildLog.
    # Writes to +log_dir+/build.log
    #
    # @param log_dir [String] Directory to write logs in
    # @return nil
    def add_build_log(log_dir:)
      appender = Appenders::BuildLog.new(log_dir: log_dir)
      add_log(vidazing_appender: appender)
    end

    # Adds a VidazingLogger::Appender::ErrorLog
    # Writes to +log_dir+/error.log
    #
    # @param log_dir [String] Directory to write logs in
    # @return nil
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

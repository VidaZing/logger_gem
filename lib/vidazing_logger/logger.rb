# frozen_string_literal: true

require 'vidazing_logger/logger_builder'

module VidazingLogger
  # Core +Logger+ class api. Calling +build+ returns a
  # logger with 4 +Appender+s attached.
  #
  # @since 0.2.0
  class Logger
    attr_reader :log_dir, :name

    # Creates the 'logs/' directory
    #
    # @param name [String] Logger name used in messages
    # @param log_dir [String] Directory to write logs in
    def initialize(log_dir = VidazingLogger::LOG_DIR, name:)
      @name = name
      @log_dir = log_dir

      create_log_dir
    end

    # Deletes the +log_dir+ directory
    def clean
      FileUtils.remove_dir(@log_dir, true)
    end

    # Create a Logger with 4 Appenders.
    # STDERR + 'logs/error.log'
    # STDOUT + 'logs/build.log'
    #
    # @return [Logging.logger] See https://github.com/TwP/logging/blob/master/lib/logging/logger.rb
    def build
      LoggerBuilder.build(name: @name) do |builder|
        builder
          .add_stdout
          .add_build_log(log_dir: @log_dir)
          .add_stderr
          .add_error_log(log_dir: @log_dir)
      end
    end

    private

    def create_log_dir
      Dir.mkdir(@log_dir) unless Dir.exist?(@log_dir)
    end
  end
end

# frozen_string_literal: true

require 'logging'

# Determines how to log messages. Attaches to Logging.logger
# @api private
module VidazingLogger::Appenders
  # Appender writing to STDERR and 'logs/error.log'
  # @api private
  module Stderr
    class << self
      private

      # ----- BUILD STDERR + LOG -----

      # Logging holds the color scheme reference
      ERROR_LOG_COLOR_SCHEME = 'bright_error'
      Logging.color_scheme(
        ERROR_LOG_COLOR_SCHEME,
        levels: {
          info: :green,
          warn: :yellow,
          error: :red,
          fatal: %i[white on_red]
        },
        date: :red,
        logger: :cyan,
        message: :magenta
      )

      def readable_error_layout_pattern
        Logging.layouts.pattern \
          pattern: '[%d] %-5l %c: %m\n',
          # ISO8601 without the 'T'
          date_pattern: '%Y-%m-%d %H:%M:%S',
          color_scheme: ERROR_LOG_COLOR_SCHEME
      end

      APPENDER_STDERR = 'STDERR'
      def stderr_appender
        Logging.appenders.stderr \
          APPENDER_STDERR,
          layout: readable_error_layout_pattern,
          level: :error
      end

      def error_log_appender(log_dir)
        error_log_path = "#{log_dir}/error.log"

        appender_error_log = error_log_path
        Logging.appenders.rolling_file \
          appender_error_log,
          layout: readable_error_layout_pattern,
          age: 'daily',
          keep: 7,
          level: :error

        Logging.appenders[appender_error_log]
      end
    end
  end
end

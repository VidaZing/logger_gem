# frozen_string_literal: true

require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to STDOUT and 'logs/build.log'
    # @api private
    module Stdout
      class << self
        APPENDER_STDOUT = 'STDOUT'
        def stdout_appender
          Logging.appenders.stdout \
            APPENDER_STDOUT,
            layout: readable_layout_pattern,
            filters: stdout_levels

          Logging.appenders[APPENDER_STDOUT]
        end

        def build_log_appender(log_dir)
          build_log_path = "#{log_dir}/build.log"

          appender_build_log = build_log_path
          Logging.appenders.rolling_file \
            appender_build_log,
            layout: readable_layout_pattern,
            age: 'daily',
            keep: 7,
            filters: stdout_levels

          Logging.appenders[appender_build_log]
        end

        private

        #----- BUILD STDOUT + LOG -----

        # Logging holds the color scheme reference
        LOG_COLOR_SCHEME = 'bright'
        Logging.color_scheme(
          LOG_COLOR_SCHEME,
          levels: {
            info: :green,
            warn: :yellow,
            error: :red,
            fatal: %i[white on_red]
          },
          date: :blue,
          logger: :cyan,
          message: :magenta
        )

        def readable_layout_pattern
          Logging.layouts.pattern \
            pattern: '[%d] %-5l %c: %m\n',
            # ISO8601 without the 'T'
            date_pattern: '%Y-%m-%d %H:%M:%S',
            color_scheme: LOG_COLOR_SCHEME
        end

        def stdout_levels
          Logging::Filters::Level.new \
            :debug,
            :info,
            :warn
        end
      end
    end
  end
end

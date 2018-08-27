# frozen_string_literal: true

require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/error'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/error.log'
    #
    # @api private
    class ErrorLog
      attr_reader :appender

      def initialize(log_dir)
        error_log_path = "#{log_dir}/error.log"

        color_scheme_name = 'vidazing_stderr'
        VidazingLogger::ColorScheme.create(color_scheme_name, date_color: :red)

        error_log_appender_name = error_log_path
        @appender =Logging.appenders.rolling_file \
          error_log_appender_name,
          layout: VidazingLogger::LayoutPattern.new(color_scheme_name).layout,
          age: 'daily',
          keep: 7,
          filters: VidazingLogger::Filters::Error.new.filter

        Logging.appenders[error_log_appender_name]
      end

    end
  end
end


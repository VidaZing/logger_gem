# frozen_string_literal: true

require 'vidazing_logger/appenders/log'
require 'vidazing_logger/filters/error'
require 'vidazing_logger/colors/error_color_scheme'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/error.log'
    #
    # @api private
    class ErrorLog < Log
      def initialize(log_dir:)
        @color_scheme_id = VidazingLogger::Colors::ErrorColorScheme.id
        @filter = VidazingLogger::Filters::Error.new.filter

        super(log_dir: log_dir, name: 'error')
      end
    end
  end
end

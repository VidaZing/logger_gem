# frozen_string_literal: true

require 'vidazing_logger/colors/error_color_scheme'
require 'vidazing_logger/filters/error'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/error.log'
    #
    # @api private
    class ErrorLog < Log
      def initialize(log_dir:)
        @filter = VidazingLogger::Filters::Error.new.filter
        @color_scheme_id = VidazingLogger::Colors::ErrorColorScheme.id

        super(log_dir: log_dir, name: 'error')
      end
    end
  end
end

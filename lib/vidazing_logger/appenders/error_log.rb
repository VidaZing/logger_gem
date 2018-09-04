# frozen_string_literal: true

require 'vidazing_logger/appenders/log'
require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/levels'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/error.log'
    #
    # @api private
    # @since 0.2.0
    class ErrorLog < Log
      def initialize(log_dir:)
        super \
          name: 'error',
          log_dir: log_dir,
          color_scheme: ColorScheme.error,
          filter_levels: Filters::Levels.error
      end
    end
  end
end

# frozen_string_literal: true

require 'vidazing_logger/colors/error_color_scheme'
require 'vidazing_logger/filters/error'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to STDERR
    #
    # @api private
    class Stderr
      attr_reader :appender

      def initialize
        color_scheme_id = VidazingLogger::Colors::ErrorColorScheme.id

        stderr_appender_name = self.class.name
        @appender = Logging.appenders.stderr \
          stderr_appender_name,
          layout: VidazingLogger::LayoutPattern.new(color_scheme_id: color_scheme_id).layout,
          filters: VidazingLogger::Filters::Error.new.filter

        Logging.appenders[stderr_appender_name]
      end
    end
  end
end

# frozen_string_literal: true

require 'vidazing_logger/colors/normal_color_scheme'
require 'vidazing_logger/filters/normal'
require 'vidazing_logger/layout'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to STDOUT
    #
    # @api private
    class Stdout
      attr_reader :appender

      def initialize
        color_scheme_id = VidazingLogger::Colors::NormalColorScheme.id

        stdout_appender_name = self.class.name
        @appender = Logging.appenders.stdout \
          stdout_appender_name,
          layout: VidazingLogger::LayoutPattern.new(color_scheme_id: color_scheme_id).layout,
          filters: VidazingLogger::Filters::Normal.new.filter

        Logging.appenders[stdout_appender_name]
      end
    end
  end
end

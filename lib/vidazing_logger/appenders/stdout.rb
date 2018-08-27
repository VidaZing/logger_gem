# frozen_string_literal: true

require 'vidazing_logger/color_scheme'
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
        color_scheme_name = 'vidazing_stdout'
        VidazingLogger::ColorScheme.create(color_scheme_name, date_color: :blue)

        stdout_appender_name = 'STDOUT'
        @appender =Logging.appenders.stdout \
          stdout_appender_name,
          layout: VidazingLogger::LayoutPattern.new(color_scheme_name).layout,
          filters: VidazingLogger::Filters::Normal.new.filter

        Logging.appenders[stdout_appender_name]
      end

    end
  end
end

# frozen_string_literal: true

require 'vidazing_logger/appender'
require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/levels'

module VidazingLogger
  module Appenders
    # Appender writing to STDOUT
    #
    # @api private
    # @since 0.1.0
    class Stdout < Appender
      def initialize
        super \
          name: self.class.name,
          color_scheme: ColorScheme.normal,
          filter_levels: Filters::Levels.normal
      end
    end
  end
end

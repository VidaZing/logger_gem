# frozen_string_literal: true

require 'vidazing_logger/appender'
require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/levels'

module VidazingLogger
  module Appenders
    # Appender writing to STDERR
    #
    # @api private
    # @since 0.1.0
    class Stderr < Appender
      def initialize
        super \
          name: self.class.name,
          color_scheme: ColorScheme.error,
          filter_levels: Filters::Levels.error
      end
    end
  end
end

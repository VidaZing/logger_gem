# frozen_string_literal: true

require 'vidazing_logger/appenders/basic'
require 'vidazing_logger/appenders/type'
require 'vidazing_logger/colors/error_color_scheme'
require 'vidazing_logger/filters/error'

module VidazingLogger
  module Appenders
    # Appender writing to STDERR
    #
    # @api private
    class Stderr < Appenders::Basic
      def initialize
        @color_scheme_id = VidazingLogger::Colors::ErrorColorScheme.id
        @filter = VidazingLogger::Filters::Error.new.filter

        appender_type = Appenders::Type::ID_STDERR
        appender_id = self.class.name
        super(type: appender_type, id: appender_id)
      end
    end
  end
end

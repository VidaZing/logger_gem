# frozen_string_literal: true

require 'vidazing_logger/appenders/basic'
require 'vidazing_logger/appenders/type'
require 'vidazing_logger/colors/normal_color_scheme'
require 'vidazing_logger/filters/normal'

module VidazingLogger
  module Appenders
    # Appender writing to STDOUT
    #
    # @api private
    class Stdout < Appenders::Basic
      def initialize
        @color_scheme_id = VidazingLogger::Colors::NormalColorScheme.id
        @filter = VidazingLogger::Filters::Normal.new.filter

        appender_type = Appenders::Type::ID_STDOUT
        appender_id = self.class.name
        super(type: appender_type, id: appender_id)
      end
    end
  end
end

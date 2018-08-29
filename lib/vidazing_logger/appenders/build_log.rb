# frozen_string_literal: true

require 'vidazing_logger/colors/normal_color_scheme'
require 'vidazing_logger/filters/normal'
require 'vidazing_logger/appenders/log'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/build.log'
    #
    # @api private
    class BuildLog < Log
      def initialize(log_dir:)
        @filter = VidazingLogger::Filters::Normal.new.filter
        @color_scheme_id = VidazingLogger::Colors::NormalColorScheme.id

        super(log_dir: log_dir, name: 'build')
      end
    end
  end
end

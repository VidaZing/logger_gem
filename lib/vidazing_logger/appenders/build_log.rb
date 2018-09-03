# frozen_string_literal: true

require 'vidazing_logger/appenders/log'
require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/levels'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/build.log'
    #
    # @api private
    class BuildLog < Log
      def initialize(log_dir:)
        super \
          name: 'build',
          log_dir: log_dir,
          color_scheme: ColorScheme.normal,
          filter_levels: Filters::Levels.normal
      end
    end
  end
end

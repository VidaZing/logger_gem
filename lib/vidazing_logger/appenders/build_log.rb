# frozen_string_literal: true

require 'vidazing_logger/color_scheme'
require 'vidazing_logger/filters/normal'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to 'logs/build.log'
    #
    # @api private
    class BuildLog
      attr_reader :appender

      def initialize(log_dir)
        build_log_path = "#{log_dir}/build.log"

        color_scheme_name = 'vidazing_stdout'
        VidazingLogger::ColorScheme.create(color_scheme_name, date_color: :blue)

        build_log_appender_name = build_log_path
        @appender =Logging.appenders.rolling_file \
          build_log_appender_name,
          layout: VidazingLogger::LayoutPattern.new(color_scheme_name).layout,
          age: 'daily',
          keep: 7,
          filters: VidazingLogger::Filters::Normal.new.filter

        Logging.appenders[build_log_appender_name]
      end

    end
  end
end


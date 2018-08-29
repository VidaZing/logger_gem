# frozen_string_literal: true

require 'vidazing_logger/filters/normal'
require 'vidazing_logger/appenders'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to log files
    #
    # @api private
    class Log
      attr_reader :appender, :log_dir, :name
      attr_accessor :filter, :layout, :color_scheme_id

      def log_path
        "#{@log_dir}/#{@name}"
      end

      def initialize(log_dir:, name:)
        @log_dir = log_dir
        @name = "#{name}.log"

        @layout = VidazingLogger::LayoutPattern.new(color_scheme_id: @color_scheme_id).layout

        log_appender_name = log_path
        @appender = Logging.appenders.rolling_file \
          log_appender_name,
          layout: @layout,
          age: 'daily',
          keep: 7,
          filters: @filter

        Logging.appenders[log_appender_name]
      end
    end
  end
end

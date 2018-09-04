# frozen_string_literal: true

require 'vidazing_logger/appender'

module VidazingLogger
  module Appenders
    # Appender writing to log files
    #
    # @api private
    # @since 0.2.0
    class Log < Appender
      attr_reader :log_dir, :name

      def log_path
        "#{@log_dir}/#{@name}"
      end

      def initialize(log_dir:, name:, color_scheme:, filter_levels:)
        @log_dir = log_dir
        @name = "#{name}.log"

        super \
          name: log_path,
          color_scheme: color_scheme,
          filter_levels: filter_levels
      end
    end
  end
end

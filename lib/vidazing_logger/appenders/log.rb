# frozen_string_literal: true

require 'vidazing_logger/filters/normal'
require 'vidazing_logger/appenders/basic'
require 'logging'

module VidazingLogger
  module Appenders
    # Appender writing to log files
    #
    # @api private
    class Log < Appenders::Basic
      attr_reader :log_dir

      def log_path
        "#{@log_dir}/#{@name}"
      end

      def initialize(log_dir:, name:)
        @log_dir = log_dir
        @name = "#{name}.log"

        appender_type = Appenders::Type::ID_ROLLING_FILE
        appender_id = log_path
        super(type: appender_type, id: appender_id)
      end
    end
  end
end

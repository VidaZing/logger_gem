# frozen_string_literal: true

require 'vidazing_logger/appenders/basic'
require 'vidazing_logger/appenders/type'
require 'vidazing_logger/layout_pattern'

module VidazingLogger
  module Appenders
    # Appender writing to log files
    #
    # @api private
    class Basic
      attr_reader :appender

      def initialize(type:, id:)
        @layout = VidazingLogger::LayoutPattern.new(color_scheme_id: @color_scheme_id).layout

        appender_args = [
          filters: @filter,
          layout: @layout,
          # These are specific to Appenders::Type.rolling_file
          # But the underlying logging library uses opts.fetch
          # So these will be ignored for other appenders types
          age: 'daily',
          keep: 7
        ]

        @appender = Appenders::Type.create \
          type: type,
          id: id,
          args: appender_args
      end
    end
  end
end

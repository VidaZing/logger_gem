# frozen_string_literal: true

require 'logging'

module VidazingLogger
  # An +Appender+ appenders log events to a logging destination.
  # All appenders use the same layout. So we store the +color_scheme+
  # instead.
  #
  # @api private
  # @since 0.2.0
  class Appender
    attr_reader :filter_levels, :name, :color_scheme

    def initialize(name:, filter_levels:, color_scheme:)
      @filter_levels = filter_levels
      @color_scheme = color_scheme
      @name = name
    end
  end
end

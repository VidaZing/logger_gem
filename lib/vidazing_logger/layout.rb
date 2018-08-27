# frozen_string_literal: true

require 'logging'

module VidazingLogger
  # Determins the format for the logger messages
  #
  # @api private
  class LayoutPattern
    attr_reader :layout

    def initialize(color_scheme_name)
      @layout = Logging.layouts.pattern \
        pattern: '[%d] %-5l %c: %m\n',
        # ISO8601 without the 'T'
        date_pattern: '%Y-%m-%d %H:%M:%S',
        color_scheme: color_scheme_name
    end

  end
end

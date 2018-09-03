# frozen_string_literal: true

module VidazingLogger
  # Determines the format for the logger messages
  #
  # @api private
  class LayoutPattern
    attr_reader :layout

    def initialize(color_scheme_name)
      @layout = LayoutPattern.basic.dup
      @layout[:color_scheme] = color_scheme_name
    end

    class << self
      def colored(color_scheme_name)
        LayoutPattern.new(color_scheme_name)
      end

      def basic
        {
          pattern: '[%d] %-5l %c: %m\n',
          # ISO8601 without the 'T'
          date_pattern: '%Y-%m-%d %H:%M:%S'
        }
      end
    end
  end
end

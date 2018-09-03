# frozen_string_literal: true

module VidazingLogger
  # Set logging colors
  #
  # @api private
  class ColorScheme
    attr_reader :name, :scheme

    def initialize(name:, date_color:)
      @name = name

      @scheme = ColorScheme.basic.dup
      @scheme[:date] = date_color
    end

    class << self
      def normal
        ColorScheme.new(name: :normal, date_color: :blue)
      end

      def error
        ColorScheme.new(name: :error, date_color: :red)
      end

      def basic
        {
          levels: {
            info: :green,
            warn: :yellow,
            error: :red,
            fatal: %i[white on_red]
          },
          logger: :cyan,
          message: :magenta
        }
      end
    end
  end
end

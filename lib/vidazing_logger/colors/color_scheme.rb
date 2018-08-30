# frozen_string_literal: true

require 'logging'

module VidazingLogger
  # Set logging colors
  #
  # @api private
  class ColorScheme
    attr_reader :name

    def self.create(name, date_color:) # rubocop:disable Metrics/MethodLength, Metrics/LineLength
      # Logging holds the color scheme reference
      Logging.color_scheme(
        name,
        levels: {
          info: :green,
          warn: :yellow,
          error: :red,
          fatal: %i[white on_red]
        },
        date: date_color,
        logger: :cyan,
        message: :magenta
      )
    end
  end
end

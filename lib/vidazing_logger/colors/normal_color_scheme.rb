# frozen_string_literal: true

require 'vidazing_logger/colors/color_scheme'
require 'logging'

module VidazingLogger
  module Colors
    # Colors for non error messages
    #
    # @api private
    class NormalColorScheme < ColorScheme
      def initialize
        @name = self.class.name

        ColorScheme.create(@name, date_color: :blue)
      end

      class << self
        def id
          new.name
        end
      end
    end
  end
end

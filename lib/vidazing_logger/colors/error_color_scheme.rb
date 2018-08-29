# frozen_string_literal: true

require 'logging'

module VidazingLogger
  module Colors
    # Colors for error messages
    #
    # @api private
    class ErrorColorScheme < ColorScheme
      def initialize
        @name = self.class.name

        ColorScheme.create(@name, date_color: :red)
      end

      class << self
        def id
          new.name
        end
      end
    end
  end
end

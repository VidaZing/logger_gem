# frozen_string_literal: true

require 'logging'

module VidazingLogger
  # Filter logs by level severity
  #
  # @api private
  module Filters
    # Filter log messages strictly by Levels. Levels...
    #
    # @see Levels::ALL
    # @api private
    module Levels
      class << self
        ALL = %i[debug info warn error fatal].freeze

        # Filter for normal messages
        def normal
          %i[debug info warn]
        end

        # Filter for error messages
        def error
          %i[error fatal]
        end
      end
    end
  end
end

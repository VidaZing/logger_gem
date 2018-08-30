# frozen_string_literal: true

require 'logging'

module VidazingLogger
  module Filters
    # Filter for non error message
    #
    # @api private
    class Normal
      attr_reader :filter

      def initialize
        # Logging::Filters::Level.new bug:
        # @filter has nil levels set on the first invocation
        #   :debug,
        #   :info,
        #   :warn
        @filter = Logging::Filters::Level.new \
          0,
          1,
          2
      end
    end
  end
end

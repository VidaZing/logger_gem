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
        @filter = Logging::Filters::Level.new \
          :debug,
          :info,
          :warn
      end
    end
  end
end

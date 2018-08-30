# frozen_string_literal: true

require 'logging'

module VidazingLogger
  module Filters
    # Filter for non error message
    #
    # @api private
    class Error
      attr_reader :filter

      def initialize
        @filter = Logging::Filters::Level.new \
          :error,
          :fatal
      end
    end
  end
end

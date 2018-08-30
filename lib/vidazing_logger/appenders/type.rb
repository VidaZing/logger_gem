# frozen_string_literal: true

require 'logging'

module VidazingLogger
  # Base Appender for logging
  # Determines how to log messages. Attaches to Logging.logger
  #
  # @api private
  module Appenders
    class Type
      ID_ROLLING_FILE = 'rolling_file'
      ID_STDOUT = 'stdout'
      ID_STDERR = 'stderr'

      TYPES = [ID_ROLLING_FILE, ID_STDERR, ID_STDOUT].freeze

      class << self
        def create(type:, id:, args:)
          abort('args is empty!') if args.empty?
          abort("Type '#{type}' is not valid.") unless valid_type?(type: type)

          args.unshift(id)

          Logging.appenders.public_send(type, *args)
          Logging.appenders[id]
        end

        private

        def valid_type?(type:)
          is_valid = false

          begin
            is_valid = Logging.appenders.respond_to?(type)
          rescue StandardError
            abort("Logging.appenders.#{type} is not a public_method." \
                  'See https://github.com/TwP/logging/')
          end

          is_valid && TYPES.include?(type)
        end
      end
    end
  end
end

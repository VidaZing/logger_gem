# frozen_string_literal: true

require 'vidazing_logger/layout_pattern'

require 'logging'

module VidazingLogger
  module Appenders
    # Uses an +appender+
    #
    # @api private
    # @since 0.2.0
    class LoggingGemAdapter
      attr_reader :vidazing_appender, :logging_appender

      def initialize(type:, vidazing_appender:)
        @vidazing_appender = vidazing_appender

        logging_filter = create_logging_filter
        logging_layout = create_logging_layout

        logging_appender_options = create_logging_appender_options \
          filter: logging_filter,
          layout: logging_layout

        @logging_appender = create_logging_appender \
          type: type,
          name: vidazing_appender.name,
          options: logging_appender_options
      end

      private

      def create_logging_appender_options(filter:, layout:)
        [
          filters: filter,
          layout: layout,
          # These are specific to Appenders::Type.rolling_file
          # But the underlying logging library uses opts.fetch
          # So these will be ignored for other appenders types
          age: 'daily',
          keep: 7
        ]
      end

      def create_logging_appender(type:, name:, options:)
        abort('options are empty!') if options.empty?
        abort("Invalid Type '#{type}'") unless Type.valid_type?(type: type)

        options.unshift(name)

        Logging.appenders.public_send(type, *options)
        Logging.appenders[name]
      end

      def create_logging_filter # rubocop:disable Metrics/MethodLength
        # Logging::Filters::Level takes *levels as its argument.
        # This means we can't store the method arguments ahead of time
        # in an array and directly pass those.
        #
        # Instead, to isolate the Logging gem reference, we hack
        level0, level1, level2, level3, level4 =
          *@vidazing_appender.filter_levels

        if level1.nil?
          Logging::Filters::Level.new(level0)
        elsif level2.nil?
          Logging::Filters::Level.new(level0, level1)
        elsif level3.nil?
          Logging::Filters::Level.new(level0, level1, level2)
        elsif level4.nil?
          Logging::Filters::Level.new(level0, level1, level2, level3)
        else
          Logging::Filters::Level.new(:all)
        end
      end

      def create_logging_color_scheme
        color_scheme = @vidazing_appender.color_scheme
        name = color_scheme.name

        # Logging holds the color scheme reference
        Logging.color_scheme(name, color_scheme.scheme)

        name
      end

      def create_logging_layout
        color_scheme_name = create_logging_color_scheme
        layout = LayoutPattern.colored(color_scheme_name).layout

        Logging.layouts.pattern layout
      end

      class << self
        def stdout(vidazing_appender:)
          LoggingGemAdapter.new(type: Type::ID_STDOUT,
                                vidazing_appender: vidazing_appender)
        end

        def stderr(vidazing_appender:)
          LoggingGemAdapter.new(type: Type::ID_STDERR,
                                vidazing_appender: vidazing_appender)
        end

        def rolling_file(vidazing_appender:)
          LoggingGemAdapter.new(type: Type::ID_ROLLING_FILE,
                                vidazing_appender: vidazing_appender)
        end
      end
    end

    # Determines what kind of logging will occur
    #
    # @see Type::ID_ROLLING_FILE, Type::ID_STDOUT, Type::ID_STDERR
    # @api private
    module Type
      ID_ROLLING_FILE = 'rolling_file'
      ID_STDOUT = 'stdout'
      ID_STDERR = 'stderr'

      TYPES = [ID_ROLLING_FILE, ID_STDERR, ID_STDOUT].freeze

      class << self
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

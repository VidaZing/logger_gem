# frozen_string_literal: true

# Test Coverage uses .simplecov
require 'simplecov'

require './lib/vidazing_logger.rb'
require 'test/unit'

class TestLoggingAppenderAdapter < Test::Unit::TestCase
  LOG_DIR = "#{name}_logs"
  NAME = name

  def setup
    FileUtils.rm_rf(LOG_DIR)
  end

  def test_create_logging_stdout_appender
    appender = VidazingLogger::Appenders::Stdout.new

    assert_nothing_raised do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: 'stdout',
        vidazing_appender: appender
    end
  end

  def test_create_logging_stderr_appender
    appender = VidazingLogger::Appenders::Stderr.new

    assert_nothing_raised do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: 'stderr',
        vidazing_appender: appender
    end
  end

  def test_create_logging_build_log_rolling_file_appender
    VidazingLogger.logger(NAME, LOG_DIR)
    appender = VidazingLogger::Appenders::BuildLog.new(log_dir: LOG_DIR)

    assert_nothing_raised do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: 'rolling_file',
        vidazing_appender: appender
    end
  end

  def test_create_logging_error_log_rolling_file_appender
    VidazingLogger.logger(NAME, LOG_DIR)
    appender = VidazingLogger::Appenders::ErrorLog.new(log_dir: LOG_DIR)

    assert_nothing_raised do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: 'rolling_file',
        vidazing_appender: appender
    end
  end

  def test_logging_appender_responds_to_types
    types = %w[stdout stderr rolling_file]

    types.each do |type|
      assert(Logging.appenders.respond_to?(type))
    end
  end

  def test_abort_invalid_appender_type
    appender = VidazingLogger::Appenders::Stderr.new
    type = 'abort'

    assert_raise(SystemExit) do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: type,
        vidazing_appender: appender
    end
  end

  def test_abort_nil_appender_type
    assert_raise(SystemExit) do
      VidazingLogger::Appenders::Type.valid_type?(type: nil)
    end
  end

  def teardown
    FileUtils.rm_rf(LOG_DIR)
  end
end

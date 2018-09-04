# frozen_string_literal: true

# Test Coverage uses .simplecov
require 'simplecov'

require './lib/vidazing_logger.rb'
require 'test/unit'

# Mocha must be required after testing frameworks
require 'mocha/test_unit'

class TestCreateLoggingFilters < Test::Unit::TestCase
  LOG_DIR = "#{name}_logs"
  NAME = name

  def setup
    FileUtils.rm_rf(LOG_DIR)
  end

  def test_one_filter_level
    filter_levels = [:debug]
    helper_mock_appender(filter_levels: filter_levels)
  end

  def test_two_filter_levels
    filter_levels = %i[debug info]
    helper_mock_appender(filter_levels: filter_levels)
  end

  def test_three_filter_levels
    filter_levels = %i[debug info warn]
    helper_mock_appender(filter_levels: filter_levels)
  end

  def test_four_filter_levels
    filter_levels = %i[debug info warn error]
    helper_mock_appender(filter_levels: filter_levels)
  end

  def test_five_filter_levels
    filter_levels = %i[debug info warn error fatal]
    helper_mock_appender(filter_levels: filter_levels)
  end

  def teardown
    FileUtils.rm_rf(LOG_DIR)
  end

  private

  def helper_mock_appender(filter_levels:)
    appender = mock_appender
    appender.stubs(:filter_levels).returns(filter_levels)

    assert_nothing_raised do
      VidazingLogger::Appenders::LoggingGemAdapter.new \
        type: 'stdout',
        vidazing_appender: appender
    end
  end

  def mock_appender
    appender = mock
    appender.stubs(:name).returns('mocked_appender')

    color_scheme = mock_color_scheme
    appender.stubs(:color_scheme).returns(color_scheme)

    appender
  end

  def mock_color_scheme
    color_scheme = mock
    color_scheme.stubs(:name).returns('mocked_colors')
    color_scheme.stubs(:scheme).returns({})

    color_scheme
  end
end

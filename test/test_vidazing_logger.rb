# frozen_string_literal: true

# Test Coverage
require 'simplecov'
SimpleCov.start

require './lib/vidazing_logger.rb'
require 'test/unit'

class TestNAME < Test::Unit::TestCase
  LOG_DIR = 'logs'

  def setup
    FileUtils.rm_rf(LOG_DIR)
  end

  def test_sample
    assert_equal(4, 2 + 2)
  end

  def test_initclean
    assert(!Dir.exist?(LOG_DIR))

    VidazingLogger.initialize
    assert(Dir.exist?(LOG_DIR))

    VidazingLogger.clean
    assert(!Dir.exist?(LOG_DIR))
  end

  def teardown
    FileUtils.rm_rf(LOG_DIR)
  end
end

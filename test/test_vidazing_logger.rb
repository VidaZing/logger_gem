# frozen_string_literal: true

# Test Coverage uses .simplecov
require 'simplecov'

require './lib/vidazing_logger.rb'
require 'test/unit'

class TestVidazingLogger < Test::Unit::TestCase
  LOG_DIR = "#{name}_logs"
  NAME = name

  def setup
    FileUtils.rm_rf(LOG_DIR)
  end

  def test_init_clean
    assert(!Dir.exist?(LOG_DIR))

    VidazingLogger.logger(NAME, LOG_DIR)
    assert(File.writable?(LOG_DIR))
    assert(Dir.exist?(LOG_DIR))

    VidazingLogger.clean(LOG_DIR)
    assert(!Dir.exist?(LOG_DIR))
  end

  def teardown
    FileUtils.rm_rf(LOG_DIR)
  end
end

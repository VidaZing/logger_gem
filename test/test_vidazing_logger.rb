require "./lib/vidazing_logger.rb"
require "test/unit"

# Test Coverage
require 'coveralls'
Coveralls.wear!


class TestNAME < Test::Unit::TestCase

  LOG_DIR = "logs"

  def setup
    FileUtils.rm_rf(LOG_DIR)
  end

  def test_sample
    assert_equal(4, 2+2)
  end

  def test_initclean
    assert(! Dir.exist?(LOG_DIR))

    VidazingLogger.initialize
    assert(Dir.exist?(LOG_DIR))

    VidazingLogger.clean
    assert(! Dir.exist?(LOG_DIR))
  end

  def teardown
    FileUtils.rm_rf(LOG_DIR)
  end
end

# describe Thing do
#   describe '.add_task' do
#     let(:repo) { Thing.repo }

#     it 'adds a new task' do
#       expect { Thing.add_task('speak @ Guru-SP') }.to change{ repo.count }.by(1)
#     end

#     context 'when title is blank' do
#       subject(:add_blank_task) { Thing.add_task('') }

#       it 'does not persist' do
#         expect { add_blank_task }.to_not change{ repo.count }
#       end

#       it { eq(false) }
#     end
#   end
# end

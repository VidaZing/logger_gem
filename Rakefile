# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow
require 'rake/testtask'
require 'coveralls/rake/task'

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'vidazing_logger/version'
VERSION = VidazingLogger::VERSION

GEM_NAME = 'vidazing_logger'

# IMPORTANT: Color can't be used for `system` commands.
GEM_NAME_VERSION = "#{GEM_NAME}-#{VERSION}"
GEM_ARTIFACT = "#{GEM_NAME_VERSION}.gem"

desc "Remove #{GEM_ARTIFACT} && Gemfile.lock".blue
task :clean do
  puts "Removing #{GEM_ARTIFACT} && Gemfile.lock".blue
  system 'rm -f *.gem Gemfile.lock'
end

desc "Build #{GEM_NAME_VERSION}".blue
task build: :clean do
  puts "Building #{GEM_NAME_VERSION}".blue
  system "gem build #{GEM_NAME}.gemspec"
end

task default: ['build']

desc "Publish #{GEM_ARTIFACT}".blue
task :publish do
  puts "Publishing #{GEM_NAME_VERSION}".blue
  system "gem push #{GEM_NAME_VERSION}.gem"
end

desc "Installs #{GEM_ARTIFACT}".blue
task install: :build do
  puts "Installing #{GEM_ARTIFACT}".blue
  system "gem install #{GEM_NAME}"
end

desc "Uninstalls #{GEM_ARTIFACT}".blue
task :uninstall do
  puts "UNINSTALLING #{GEM_ARTIFACT}".inverse.blue
  system "gem uninstall -xq #{GEM_NAME}"
end

namespace :dev do
  desc 'Analyze code quality (rubocop, flog, flay)'
  task :quality do
    puts 'Analyzing format with rubocop'.blue
    system 'bundle exec rubocop'

    puts 'Checking code quality. Lower is better'.blue
    system 'bundle exec flog lib/'

    puts 'Checking code duplication. Prime to refactor'.blue
    system 'bundle exec flay lib/'
  end
end

namespace :doc do
  desc "Build documentation into 'doc/'"
  task :build do
    puts "Building documentation into 'doc/':".blue
    system 'yard'
  end

  desc 'Find undocumented code'
  task :coverage do
    puts 'Documentation coverage:'.blue
    system 'yard stats --list-undoc'
  end

  desc 'See local documentation at http://localhost:8808'
  task :serve do
    system 'yard server --reload'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

namespace :loop do # rubocop:disable Metrics/BlockLength
  def looper?
    puts "Checking for 'fswatch' to monitor files".blue

    has_fswatch = !`which fswatch`.empty?

    unless has_fswatch
      abort('fswatch is NOT installed. Visit https://github.com/emcrisostomo/fswatch'.bright.red)
    end

    puts('fswatch is installed.'.bright.green) if has_fswatch
  end

  def looping(cmd)
    exclude = '-e Gemfile.lock -e .git/ -e *.gem -e logs -e .yardoc -e bundle/'
    fswatch_cmd = "fswatch -0 #{exclude} -l 1 ."

    xargs_cmd = "xargs -0 -I {} sh -c \"echo 'File: {}' && %s\""

    looping_cmd = "#{fswatch_cmd} |  #{xargs_cmd}"
    system format(looping_cmd.to_s, cmd)
  end

  IGNORED_MESSAGE = 'Ignores .git/, Gemfile.lock, logs/, .yardoc/, bundle/, '\
                    'and gems created. Watches every 1 seconds'

  desc 'Repeatedly see dev:quality on file changes'
  task :"dev:quality" do
    looper?
    puts "Analyzing dev:quality on file changes. #{IGNORED_MESSAGE}".blue
    looping('rake dev:quality')
  end

  desc 'Repeatedly show documentation coverage on file changes'
  task :"doc:coverage" do
    looper?
    puts "Showing undocumented code on file changes. #{IGNORED_MESSAGE}".blue
    looping('rake doc:coverage')
  end

  desc 'Repeatedly installs the gem on file changes'
  task :install do
    looper?
    puts "Rebuilding on file changes. #{IGNORED_MESSAGE}".blue
    looping('rake uninstall install')
  end

  desc 'Repeatedly runs tests on file changes'
  task :test do
    looper?
    puts "Running tests on file changes. #{IGNORED_MESSAGE}".blue
    looping('rake test')
  end
end

Coveralls::RakeTask.new

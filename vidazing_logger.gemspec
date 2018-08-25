# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'vidazing_logger/version'

Gem::Specification.new do |s|
  s.name        = 'vidazing_logger'
  s.version     = VidazingLogger::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['VidaZing, Inc.']
  s.licenses    = ['MIT']
  s.email       = ['VidaZing@gmail.com']
  s.homepage    = 'https://github.com/VidaZing/logger_gem'
  s.summary     = 'Custom logging for VidaZing.'
  s.executables << 'vidazing_logger'

  s.rubygems_version = '2.5.2'
  s.required_ruby_version = '>= 1.9.3'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  s.require_paths = ['lib']
  # s.test_files = ["test/test_vidazing_logger.rb"]

  s.add_runtime_dependency('logging', '2.2.2')

  s.add_development_dependency 'byebug', '10.0.2'
  s.add_development_dependency 'coveralls', '0.8.22'
  s.add_development_dependency 'pry', '0.10.4'
  s.add_development_dependency 'pry-byebug', '3.6.0'
  s.add_development_dependency 'rainbow', '3.0.0'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rspec', '3.8.0'
  s.add_development_dependency 'rubocop', '0.58.2'
  s.add_development_dependency 'simplecov', '0.16.1'
  s.add_development_dependency 'test-unit', '3.2.8'
  s.add_development_dependency 'yard', '0.9.16'
end

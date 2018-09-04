# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'vidazing_logger/version'

Gem::Specification.new do |s| # rubocop:disable Metrics/BlockLength
  s.name        = 'vidazing_logger'
  s.version     = VidazingLogger::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['VidaZing, Inc.']
  s.licenses    = ['MIT']
  s.email       = ['VidaZing@gmail.com']
  s.homepage    = 'https://github.com/VidaZing/logger_gem'
  s.summary     = 'Custom logging for VidaZing.'
  s.executables << 'vidazing_logger'

  s.rubygems_version = '2.7.7'
  s.required_ruby_version = '>= 2.5.1'

  s.files         = `git ls-files -z`.split("\x0").reject \
                     { |f| f.match(%r{^(test|spec)/}) }
  s.require_paths = ['lib']

  s.add_runtime_dependency('logging', '2.2.2')

  s.add_development_dependency 'awesome_print', '1.8.0'
  s.add_development_dependency 'byebug', '10.0.2'
  s.add_development_dependency 'coveralls', '0.8.22'
  s.add_development_dependency 'flay', '2.12.0'
  s.add_development_dependency 'flog', '4.6.2'
  s.add_development_dependency 'pry', '0.10.4'
  s.add_development_dependency 'pry-byebug', '3.6.0'
  s.add_development_dependency 'pry-rescue', '1.4.5'
  s.add_development_dependency 'pry-stack_explorer', '0.4.9.2'
  s.add_development_dependency 'rainbow', '3.0.0'
  s.add_development_dependency 'rake', '12.3.1'
  s.add_development_dependency 'rspec', '3.8.0'
  s.add_development_dependency 'rubocop', '0.58.2'
  s.add_development_dependency 'simplecov', '0.16.1'
  s.add_development_dependency 'test-unit', '3.2.8'
  s.add_development_dependency 'yard', '0.9.16'

  # Note: Mocha says to load this after test-unit
  s.add_development_dependency 'mocha', '1.7.0'
end

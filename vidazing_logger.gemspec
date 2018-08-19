# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "vidazing_logger/version"

Gem::Specification.new do |s|
  s.name        = "vidazing_logger"
  s.version     = VidazingLogger::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["VidaZing, Inc."]
  s.licenses     = ['MIT']
  s.email       = ["VidaZing@gmail.com"]
  s.homepage    = "https://github.com/VidaZing/logger_gem"
  s.summary     = "Custom logging for VidaZing."
  s.executables << 'vidazing_logger'

  s.required_ruby_version     = '>= 1.9.3'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency('logging', '2.2.2')

  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rainbow', '3.0.0'
end


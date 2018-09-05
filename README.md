# logger-gem [![Gem Version](https://badge.fury.io/rb/vidazing_logger.svg)](https://badge.fury.io/rb/vidazing_logger)

[![Build Status](https://travis-ci.org/VidaZing/logger_gem.svg?branch=master)](https://travis-ci.org/VidaZing/logger_gem)
[![Inline docs](http://inch-ci.org/github/VidaZing/logger_gem.svg?branch=master)](http://inch-ci.org/github/VidaZing/logger_gem)
[![Coverage Status](https://coveralls.io/repos/github/VidaZing/logger_gem/badge.svg?branch=master)](https://coveralls.io/github/VidaZing/logger_gem?branch=master)

VidaZing logging strategy using [TwP/logging](https://github.com/TwP/logging).

Writes to rolling log files and the corresponding IO pipe.

* <img src="http://medyk.org/colors/ff8787.png" style="border: 1px solid black" width="20" height="20" /> timestamps for: `logs/error.log` + stderr.
* <img src="http://medyk.org/colors/87d7ff.png" style="border: 1px solid black" width="20" height="20" /> timestamps for: `logs/build.log` + stdout.

1. [**Installation**](#installation)
2. [**Usage**](#usage)

## Installation

1. In your `Gemfile`, add the `vidazing_logger` gem:

    ```ruby
    gem 'vidazing_logger', '~> 0.2'
    ```

2. In your `shell`, run:

    ```ruby
    bundle install
    ```

3. (Optional - If you want to use the `rake loop:` tasks) Install [fswatch](https://github.com/emcrisostomo/fswatch)

4. (Optional - If you use `pry`) Ran into a [byebug issue](https://github.com/deivid-rodriguez/byebug/issues/440) that you can fix with:

    ```ruby
    gem install byebug
    gem install pry-byebug
    ```

## Usage
See `rake -T`

### Gem
```ruby
require 'vidazing_logger'

# Easy
optional_name = "DearDiary"
optional_log_dir = 'logs'
logger = VidazingLogger.logger(optional_name, optional_log_dir)

# Customized. See VidazingLogger::Logger#build
LoggerBuilder.build(name: @name) do |builder|
  builder
    .add_stdout
    .add_build_log(log_dir: @log_dir)
    .add_stderr
    .add_error_log(log_dir: @log_dir)
end

```

### Binary

`vidazing_logger` for all your stand alone shell logging needs. We should probably let you disable the `logs/` file logging... Moving along!

Install with `gem install vidazing_logger`

See `vidazing_logger --help`

## Under the hood

[Logging gem docs](https://www.rubydoc.info/gems/logging/toplevel)

### Considering

[Timber](https://github.com/timberio/timber-ruby)

# logger-gem

[![Build Status](https://travis-ci.org/VidaZing/logger_gem.svg?branch=master)](https://travis-ci.org/VidaZing/logger_gem)
[![Gem Version](https://badge.fury.io/rb/vidazing_logger.svg)](https://badge.fury.io/rb/vidazing_logger)

VidaZing logging strategy using [TwP/logging](https://github.com/TwP/logging).

Writes to rolling log files and the corresponding IO pipe.

* <span style="color:red">Red</span> timestamps: `logs/error.log` + stderr.
* <span style="color:blue">Blue</span> timestamps: `logs/build.log` + stdout.

1. [**Installation**](#installation)
2. [**Usage**](#usage)

## Installation

1. In your `Gemfile`, add the `vidazing_logger` gem:

    ```ruby
    gem 'vidazing_logger', '~> 0.1'
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

logger = VidazingLogger.logger("OPTIONAL_LOGGER_NAME")
```

### Binary

`vidazing_logger` for all your stand alone shell logging needs. We should probably let you disable the `logs/` file logging... Moving along!

Install with `gem install vidazing_logger`

See `vidazing_logger --help`

## Under the hood

[Logging gem docs](https://www.rubydoc.info/gems/logging/toplevel)

### Considering

[Timber](https://github.com/timberio/timber-ruby)

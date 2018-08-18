# logger-gem
Customized ruby logging with [TwP/logging](https://github.com/TwP/logging). Uses rotating log files with correct IO pipe. E.g.  `logs/error.log` + stderr. `logs/build.log` + stdout.

1. [**Installation**](#installation)
2. [**Usage**](#usage)

## Installation

1. In your `Gemfile`, add the `vidazing_logger` gem:

    ```ruby
    gem 'vidazing_logger', '~> 0.8'
    ```

2. In your `shell`, run:

    ```
    bundle install
    ```

## Usage

```ruby
require 'vidazing_logger'

logger = VidazingLogger.new
```

## Under the hood

[Logging gem docs](https://www.rubydoc.info/gems/logging/toplevel)

## Considering

[Timber](https://github.com/timberio/timber-ruby)

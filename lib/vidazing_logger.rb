require 'vidazing_logger/version'
require 'vidazing_logger/appenders/stdout'
require 'vidazing_logger/appenders/stderr'

require 'logging'

module VidazingLogger
  class << self

    LOG_DIR = "logs"

    def initialize
      Dir.mkdir(LOG_DIR) unless Dir.exists?(LOG_DIR)
    end

    def clean
      FileUtils.remove_dir(LOG_DIR, true)
    end

    def logger(name = 'VidaZing')
      VidazingLogger.initialize

      log = Logging.logger[name]
      log.add_appenders \
        VidazingLogger::Appenders::Stdout.stdout_appender,
        VidazingLogger::Appenders::Stdout.build_log_appender(LOG_DIR),
        VidazingLogger::Appenders::Stderr.stderr_appender,
        VidazingLogger::Appenders::Stderr.error_log_appender(LOG_DIR)

      log
    end
  end
end

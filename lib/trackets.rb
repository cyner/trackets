require "trackets/version"
require "trackets/railtie" if defined?(Rails)
require "trackets/middleware/rack_exception_handler"
require "trackets/configuration"
require "trackets/jobs/notice_job"

module Trackets
  class << self

    def setup
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def notify(exception, env = nil)
      job = NoticeJob.new
      job = job.async if Trackets.configuration.async?

      job.perform(exception, env)
    end

    class TracketsCustomException < StandardError; end

    def send_custom_exception(message = nil)
      begin
        raise TracketsCustomException, message
      rescue TracketsCustomException => e
        Trackets.notify(e)
      end
    end

  end
end

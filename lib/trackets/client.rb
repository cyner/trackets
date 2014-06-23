require "httparty"
require "trackets/backtrace"
require "trackets/params"
require "trackets/null_env"
require "trackets/rack_env_sanitizer"

module Trackets
  class Client

    include HTTParty

    class << self

      def notify(exception, env, additional_info = {})
        new(exception, env, additional_info).send
      end

    end

    attr_reader :exception, :env
    attr_accessor :additional_info

    def initialize(exception, env, additional_info)
      @exception = exception
      @env = env
      @additional_info = additional_info
    end

    def backtrace
      @backtrace ||= Backtrace.new(exception.backtrace)
    end

    def params
      @params ||= env ? Params.new(env) : NullEnv.new
    end

    def rack_env_sanitizer
      @rack_env_sanitizer ||= env ? RackEnvSanitizer.new(env) : NullEnv.new
    end

    def payload
      {
        language:         "ruby",
        message:          exception.message,
        class_name:       exception.class.to_s,
        stacktrace:       backtrace.parse.join("\n"),
        env:              rack_env_sanitizer.filtered,
        environment_name: config.environment_name,
        project_root:     config.project_root,
        framework:        config.framework,
        params:           params.filtered,
        additional_info:  additional_info
      }
    end

    def config
      Trackets.configuration
    end

    def send
      self.class.post "#{config.api_url}/reports/#{config.api_key}", body: { error: payload }
    end
  end
end

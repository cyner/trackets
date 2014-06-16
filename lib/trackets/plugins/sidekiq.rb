module Trackets
  module Plugins
    class Sidekiq

      def initialize
        if defined?(::Sidekiq)
          ::Sidekiq.configure_server do |config|
            config.error_handlers << Proc.new {|ex,ctx_hash| Trackets.notify(ex) }
          end
        end
      end

    end
  end
end

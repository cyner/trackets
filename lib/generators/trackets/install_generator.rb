module Trackets
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root ::File.expand_path('../templates', __FILE__)

      argument :api_key
      desc "Creates Trackets configuration file in config/initializers"
      def install
        template "initializer.rb", "config/initializers/trackets.rb"
      end
    end
  end
end

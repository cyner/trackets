# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trackets/version'

Gem::Specification.new do |spec|
  spec.name          = "trackets"
  spec.version       = Trackets::VERSION
  spec.authors       = ["Jan Votava"]
  spec.email         = ["votava@deployment.cz"]
  spec.summary       = %q{Trackets.com Ruby support GEM}
  spec.description   = %q{Helpers for Trackets.com error tracking service}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "httparty", "~> 0.13"
  spec.add_runtime_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

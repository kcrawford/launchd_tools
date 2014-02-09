# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'launchd_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "launchd_tools"
  spec.version       = LaunchdTools::VERSION
  spec.authors       = ["Kyle Crawford"]
  spec.email         = ["kcrwfrd@gmail.com"]
  spec.description   = %q{Provides tools for converting from command line arguments to a formatted launchd plist and vice versa}
  spec.summary       = %q{launchd tools convert from command to launchd and launchd to command}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end

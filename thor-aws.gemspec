# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thor/aws/version'

Gem::Specification.new do |spec|
  spec.name          = "thor-aws"
  spec.version       = Thor::Aws::VERSION
  spec.authors       = ["y13i"]
  spec.email         = ["email@y13i.com"]
  spec.summary       = %(Thor += AWS)
  spec.description   = %(Thor extension for building CLI to deal with AWS.)
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor"
  spec.add_dependency "aws-sdk"
end

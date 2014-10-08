# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bio/snpeff/version'

Gem::Specification.new do |spec|
  spec.name          = "bio-snpeff"
  spec.version       = Bio::Snpeff::VERSION
  spec.authors       = ["Fedor Gusev"]
  spec.email         = ["gusevfe@gmail.com"]
  spec.summary       = %q{Parse SnpEff annotations in Ruby!}
  spec.description   = %q{A parser for annotations produced by SnpEff}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'parslet'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

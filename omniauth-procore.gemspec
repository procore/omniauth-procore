# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/procore/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-procore"
  spec.version       = Omniauth::Procore::VERSION
  spec.authors       = ["Procore Engineering"]
  spec.email         = ["dev@procore.com"]

  spec.summary       = %q{Official OmniAuth strategy for Procore.}
  spec.description   = %q{Official OmniAuth strategy for Procore.}
  spec.homepage      = "https://procore.com"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

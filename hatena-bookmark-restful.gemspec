# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hatena/bookmark/restful/version'

Gem::Specification.new do |spec|
  spec.name          = "hatena-bookmark-restful"
  spec.version       = Hatena::Bookmark::Restful::VERSION
  spec.authors       = ["aereal"]
  spec.email         = ["aereal@aereal.org"]
  spec.summary       = %q{A client library for Hatena::Bookmark RESTful API}
  spec.description   = %q{A client library for Hatena::Bookmark RESTful API}
  spec.homepage      = "https://github.com/aereal/hatena-bookmark-restful"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "simple_oauth"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "semantic"
  spec.add_development_dependency "yard"
end

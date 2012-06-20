# -*- encoding: utf-8 -*-
require File.expand_path('../lib/singlyr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency('rspec', '~> 2.10.0')
  gem.add_development_dependency('webmock', '~> 1.8.7')
  gem.add_runtime_dependency('faraday', '~> 0.8.1')
  gem.add_runtime_dependency('faraday_middleware', '~> 0.8.7')
  gem.add_runtime_dependency('multi_json', '~> 1.3.6')
  gem.add_runtime_dependency('hashie',  '>= 1.2.0')
  gem.authors       = ["Edgar Gonzalez"]
  gem.email         = ["edgargonzalez@gmail.com"]
  gem.description   = %q{A ruby wrapper for Singly API}
  gem.homepage      = "http://github.com/edgar/singlyr"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "singlyr"
  gem.require_paths = ["lib"]
  gem.version       = Singlyr::VERSION
end

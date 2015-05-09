# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_cached_settings/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_cached_settings'
  spec.version       = SimpleCachedSettings::VERSION
  spec.authors       = ['Le6ow5k1']
  spec.email         = ['Le6oww5k1@gmail.com']
  spec.summary       = %q{Gem for storing global configuration settings in an ActiveRecord::Model}
  spec.homepage      = 'https://github.com/Le6ow5k1/simple_cached_settings'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'rails', '>= 4.0.0'
end

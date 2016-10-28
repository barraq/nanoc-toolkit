lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nanoc/toolkit/version'

Gem::Specification.new do |spec|
  spec.name = 'nanoc-toolkit'
  spec.version = Nanoc::Toolkit::VERSION
  spec.authors = ['Remi Barraquand']
  spec.email = ['dev@remibarraquand.com']

  spec.summary = 'Collection of filters, helpers, recipes for Nanoc'
  spec.description = 'Collection of filters, helpers, recipes for Nanoc'
  spec.homepage = 'http://barraq.github.com/nanoc-toolkit/'
  spec.license = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.3')

  spec.add_dependency 'nanoc', '~> 4.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'simplecov'

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.require_paths = ['lib']
end

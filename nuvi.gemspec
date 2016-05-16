# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nuvi/version'

Gem::Specification.new do |spec|
  spec.name          = 'nuvi'
  spec.version       = Nuvi::VERSION
  spec.authors       = ['Igor Kim']
  spec.email         = ['yorikim@gmail.com']

  spec.summary       = 'Simple test gem for NUVI'
  spec.description   = 'Simple test gem for NUVI'
  spec.homepage      = 'https://github.com/yorikim/nuvi'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'fuubar', '~> 2.0'
  spec.add_development_dependency 'rubocop', '~> 0.40'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 2.0'
  spec.add_development_dependency 'fakeredis', '~> 0.3'

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'mechanize', '~> 2.7'
  spec.add_runtime_dependency 'cocoapods-downloader', '~> 0.3'
  spec.add_runtime_dependency 'workers', '~> 0.6'
  spec.add_runtime_dependency 'ruby-progressbar', '~> 1.8'
  spec.add_runtime_dependency 'redis-objects', '~> 1.2'
end

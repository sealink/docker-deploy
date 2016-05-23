# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'docker/deploy/version'

Gem::Specification.new do |spec|
  spec.name          = 'docker-deploy'
  spec.version       = Docker::Deploy::VERSION
  spec.authors       = [ 'Alvin Yim' ]
  spec.email         = [ 'alvin.yim@sealink.com.au' ]

  spec.summary       = 'Tag the Git repo for Docker Hub to build the image'
  spec.description   = 'Tag the Git repo for Docker Hub to build the image'
  spec.homepage      = 'https://github.com/sealink/docker-deploy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match %r{^(test|spec|features)/} }

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename f }
  spec.require_paths = [ 'lib' ]

  spec.add_dependency 'deploy_aws', '~> 0.1.0'
end

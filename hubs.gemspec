# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hub/version'

Gem::Specification.new do |spec|
  spec.name          = 'hubs'
  spec.version       = Hub::VERSION
  spec.authors       = ['Eric Guo']
  spec.email         = ['eric.guocz@gmail.com']

  spec.summary       = 'hubs is a Wechat Moment clone gem.'
  spec.description   = 'hubs is a Wechat Moment clone gem.'
  spec.homepage      = 'https://github.com/bayetech/hubs'
  spec.license       = 'MIT'
  spec.required_ruby_version = '~> 2.2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end - %w(CODE_OF_CONDUCT.md hubs.sublime-project Gemfile Rakefile hubs.gemspec bin/setup bin/console certs/Eric-Guo.pem)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.cert_chain  = ['certs/Eric-Guo.pem']
  spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  spec.add_runtime_dependency 'activerecord', '>= 4.2.7', '< 5.1.x'
  spec.add_dependency 'carrierwave', '~> 0.11.2'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moyasar/version'

Gem::Specification.new do |spec|
  spec.name          = 'moyasar'
  spec.version       = Moyasar::VERSION
  spec.authors       = ['Abdulaziz AlShetwi', 'Moyasar Dev Team']
  spec.email         = ['developers@moyasar.com']

  spec.summary       = %q{Ruby wrapper library for Moyasar Payment Service}
  spec.description   = %q{Ruby wrapper library for Moyasar Payment Service}
  spec.homepage      = 'https://moyasar.com/docs/api?ruby'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler' # , "~> 1.10"
  spec.add_development_dependency 'rake' # , "~> 10.0"
  spec.add_development_dependency 'minitest'

  spec.required_ruby_version = '>= 2.1.10'
end

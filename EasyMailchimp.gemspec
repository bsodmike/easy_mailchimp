# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_mailchimp/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_mailchimp"
  spec.version       = EasyMailchimp::VERSION
  spec.authors       = ["Michael de Silva"]
  spec.email         = ["michael@mwdesilva.com"]

  spec.summary       = %q{Easy Mailchimp Ruby library}
  spec.description   = %q{Easy Mailchimp Ruby library}
  spec.homepage      = "https://github.com/bsodmike/easy_mailchimp"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.3'

  spec.add_runtime_dependency "gibbon", "~> 2.2.0"
  spec.add_runtime_dependency "activesupport", ">= 4.2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

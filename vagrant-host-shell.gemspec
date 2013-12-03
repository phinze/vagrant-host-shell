# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vagrant-host-shell/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-host-shell"
  spec.version       = VagrantPlugins::HostShell::VERSION
  spec.authors       = ["Paul Hinze", "Carlos Brito Lage"]
  spec.email         = ["paul.t.hinze@gmail.com", "carlos@compstak.com"]
  spec.description   = %q{a vagrant provisioner to run commands on the host}
  spec.summary       = %q{a vagrant provisioner to run commands on the host}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

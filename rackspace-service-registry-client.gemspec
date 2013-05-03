# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |spec|
  spec.name = "rackspace-service-registry-client"
  spec.version = "0.0.1"
  spec.authors = ["Dominic LoBue", "Jay Faulkner"]
  spec.description = "Rackspace Service Registry Client Ruby Bindings, built on top of fog."
  spec.email = ["dominic.lobue@rackspace.com", "jay.faulkner@rackspace.com"]
  spec.homepage = "https://github.com/racker/ruby-service-registry-client"
  spec.summary = "Rackspace Service Registry Ruby Bindings"
  spec.licenses = ["APACHE-2"]
  spec.platform = Gem::Platform::RUBY
  spec.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  spec.files = FileList[
    'lib/**/*.rb'
  ]
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency'fog', "~> 1.10.1"
end

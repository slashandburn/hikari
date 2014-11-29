# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hikari/version"

Gem::Specification.new do |s|
  s.name        = "hikari"
  s.version     = Hikari::VERSION
  s.authors     = ["Seth Faxon"]
  s.email       = ["seth.faxon@gmail.com"]
  s.homepage    = "https://github.com/sfaxon/hikari"
  s.summary     = %q{Hikari is a field and scope based sorting helper for Rails.}
  s.description = %q{Hikari allows sorting in Rails projects based on fields or scopes.
Sorting can be done across models via scopes.}

  s.rubyforge_project = "hikari"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.extra_rdoc_files = [
    "MIT-LICENSE",
    "README.rdoc"
  ]

  # specify any dependencies here; for example:
  s.add_dependency "activerecord", ">= 4.0.0"
  s.add_dependency "actionpack",   ">= 4.0.0"

  s.add_development_dependency "rspec", "~> 3.1.0"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "rake", ">= 0"
  s.add_development_dependency "bundler", ">= 1.0.0"

end

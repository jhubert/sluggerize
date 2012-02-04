# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sluggerize/version"

Gem::Specification.new do |s|
  s.name        = "sluggerize"
  s.version     = Sluggerize::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy Hubert"]
  s.email       = ["jhubert@gmail.com"]
  s.homepage    = "https://github.com/jhubert/sluggerize"
  s.summary     = %q{Simple library for creating a slug column from another string column}
  s.description = %q{Creates a slug from the specified column of any model.}

  s.add_dependency "activerecord", "~> 3.0"
  s.rubyforge_project = "sluggerize"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

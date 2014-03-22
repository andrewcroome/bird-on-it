$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bird_on_it/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bird_on_it"
  s.version     = BirdOnIt::VERSION
  s.authors     = ["Andrew Croome"]
  s.email       = ["andrewcroome@gmail.com"]
  s.homepage    = "https://github.com/andrewcroome/bird-on-it"
  s.summary     = "Provides simple decorators for Ruby on Rails."
  s.description = "Simple decorators for Ruby on Rails."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"

  s.add_development_dependency "sqlite3"
end

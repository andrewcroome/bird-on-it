$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bird_on_it/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bird_on_it"
  s.version     = BirdOnIt::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BirdOnIt."
  s.description = "TODO: Description of BirdOnIt."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.3"

  s.add_development_dependency "sqlite3"
end

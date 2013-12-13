$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_model_form_objects/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_model_form_objects"
  s.version     = ActiveModelFormObjects::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveModelFormObjects."
  s.description = "TODO: Description of ActiveModelFormObjects."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end

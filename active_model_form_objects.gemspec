$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_model/form_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_model_form_objects"
  s.version     = ActiveModelFormObjects::VERSION
  s.license     = 'MIT'
  s.authors     = ["Matt Freer"]
  s.email       = ["matt.freer@gmail.com"]
  s.homepage    = "https://github.com/mattfreer/active_model_form_objects"
  s.summary     = "Active Model Form Objects"
  s.description = "Provides an ActiveModel::FormObject module that can be included into a PORO. A Rails Generator for Form Objects is included in the Gem."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 3.0.2"
  s.add_development_dependency "rspec-activemodel-mocks", "~> 1.0.1"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pry"
end

require 'rails'
require 'rails/generators'

module ActiveModel
  module FormObject
    class Railtie < Rails::Railtie
      railtie_name :form_object

      config.after_initialize do
        generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
        Rails::Generators.configure! generators
        require_relative 'generators/form_object_generator'
      end
    end
  end
end

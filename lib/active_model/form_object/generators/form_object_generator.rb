require 'rails/generators'
require_relative 'rspec/form_object_generator'
require_relative 'test_unit/form_object_generator'

module ActiveModel
  module Generators
    class FormObjectGenerator < Rails::Generators::NamedBase
      desc "Generate a FormObject in app/form_objects/"
      source_root File.expand_path('../templates', __FILE__)

      argument :name,
        :type => :string,
        :banner => "resource"

      argument :operation,
        :type => :string,
        :default => "create",
        :banner => "operation"

      class_option :parent,
        :type => :string,
        :desc => 'The parent class for the generated form_object'

      hook_for :test_framework

      def create_form_object
        template 'form_object.rb', File.join('app/form_objects', class_path, "#{file_name}_#{operation}.rb")
      end

      protected

      def klass_name
        "#{class_name}#{operation.capitalize}"
      end

      def has_parent_class?
        options.has_key?("parent")
      end

      def parent_class_name
        if has_parent_class?
          options[:parent]
        end
      end
    end
  end
end

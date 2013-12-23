require 'rails'

module ActiveModel
  module Generators
    class TestGenerator < Rails::Generators::NamedBase

      argument :name,
        :type => :string,
        :banner => "resource"

      argument :operation,
        :type => :string,
        :default => "create",
        :banner => "operation"

      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        template 'form_object_spec.rb',
          File.join('spec/form_objects', class_path, "#{file_name}_#{operation}_spec.rb")
      end

      protected

      def klass_name
        "#{class_name}#{operation.capitalize}"
      end
    end
  end
end


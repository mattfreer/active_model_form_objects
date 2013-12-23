module TestUnit
  module Generators
    class FormObjectGenerator < ::Rails::Generators::NamedBase
      desc "Generate a FormObject test in test/form_objects/"

      argument :name,
        :type => :string,
        :banner => "resource"

      argument :operation,
        :type => :string,
        :default => "create",
        :banner => "operation"

      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        template 'form_object_test.rb',
          File.join('test/form_objects', class_path, "#{file_name}_#{operation}_test.rb")
      end

      protected

      def klass_name
        "#{class_name}#{operation.capitalize}"
      end
    end
  end
end

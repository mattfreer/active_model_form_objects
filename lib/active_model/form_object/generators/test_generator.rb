require 'rails'

module ActiveModel
  module Generators
    class TestGenerator < Rails::Generators::NamedBase
      # hides this generator from the available ones when running rails generator command
      hide!

      argument :name,
        :type => :string,
        :banner => "resource"

      argument :operation,
        :type => :string,
        :default => "create",
        :banner => "operation"

      def copy_files
        template template_name,
          File.join(test_dir_path, class_path, "#{file_name}_#{operation}_#{test_suffix}.rb")
      end

      protected

      def klass_name
        "#{class_name}#{operation.camelize}"
      end
    end
  end
end


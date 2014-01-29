require 'active_model/form_object/generators/test_generator'

module Rspec
  module Generators
    class FormObjectGenerator < ActiveModel::Generators::TestGenerator
      hide!

      source_root File.expand_path('../templates', __FILE__)

      def copy_shared_example
        template "shared_example.rb",
          File.join(support_dir_path, "form_object.rb")
      end

      private

      def template_name
        'form_object_spec.rb'
      end

      def test_dir_path
        'spec/form_objects'
      end

      def support_dir_path
        'spec/support/shared_examples'
      end

      def test_suffix
        'spec'
      end
    end
  end
end

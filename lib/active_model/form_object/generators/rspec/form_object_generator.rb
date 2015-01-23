require 'active_model/form_object/generators/test_generator'

module Rspec
  module Generators
    class FormObjectGenerator < ActiveModel::Generators::TestGenerator
      hide!

      source_root File.expand_path('../templates', __FILE__)

      def copy_shared_example
        case self.behavior
        when :invoke
          template 'shared_example.rb', shared_example_path if shared_example_not_created?
        when :revoke
          template 'shared_example.rb', shared_example_path if last_active_model_form_object?
        end
      end

      private

      def shared_example_path
        File.join(support_dir_path, "form_object.rb")
      end

      def last_active_model_form_object?
        Dir[File.join('app/form_objects', '**', '*')].count { |file| File.file?(file) } < 2
      end

      def shared_example_not_created?
        !File.exist?(shared_example_path)
      end

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

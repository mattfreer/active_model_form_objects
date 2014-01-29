require 'active_model/form_object/generators/test_generator'

module TestUnit
  module Generators
    class FormObjectGenerator < ActiveModel::Generators::TestGenerator
      hide!

      source_root File.expand_path('../templates', __FILE__)

      private

      def template_name
        'form_object_test.rb'
      end

      def test_dir_path
        'test/unit/form_objects'
      end

      def test_suffix
        'test'
      end
    end
  end
end

require 'active_model/form_object/generators/test_generator'

module MiniTest
  module Generators
    class FormObjectGenerator < ActiveModel::Generators::TestGenerator
      desc "Generate a FormObject mini_test in test/form_objects/"

      source_root File.expand_path('../templates', __FILE__)
      class_option :spec, :type => :boolean, :default => false, :desc => "Use MiniTest::Spec DSL"

      private

      def template_type
        options[:spec] ? "spec" : "test"
      end

      def template_name
        "form_object_#{ template_type }.rb"
      end

      def test_dir_path
        "test/form_objects"
      end

      def test_suffix
        "test"
      end
    end
  end
end

require 'active_model/form_object/generators/test_generator'

module Rspec
  module Generators
    class FormObjectGenerator < ActiveModel::Generators::TestGenerator
      desc "Generate a FormObject spec in spec/form_objects/"

      source_root File.expand_path('../templates', __FILE__)

      private

      def template_name
        'form_object_spec.rb'
      end

      def test_dir_path
        'spec/form_objects'
      end

      def test_suffix
        'spec'
      end
    end
  end
end

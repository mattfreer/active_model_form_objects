require 'spec_helper'
require 'generator_spec'

TMP_ROOT = File.expand_path("../../tmp", __FILE__);

describe ActiveModel::Generators::FormObjectGenerator, type: :generator do
  destination TMP_ROOT

  let(:name) { "user" }
  let(:operation) { nil }
  let(:options) { }
  let(:args) { [name, operation, options] }

  before(:each) do
    prepare_destination
    run_generator(args)
  end

  after do
    FileUtils.rm_rf(TMP_ROOT)
  end

  context "with 'update' operation option" do
    let(:operation) { 'update' }
    let(:form_object_file) { "app/form_objects/user_update.rb" }

    specify "should have directory structure" do
      destination_root.should have_structure {
        directory "app" do
          directory "form_objects" do
            file "user_update.rb" do
              contains load_from_file("user_update.txt")
            end
          end
        end
      }
    end

    specify "spec directory structure" do
      destination_root.should have_structure {
        directory "spec" do
          directory "form_objects" do
            file "user_update_spec.rb" do
              contains load_from_file("user_update_spec.txt")
            end
          end
        end
      }
    end
  end

  context "with default operation option" do
    let(:form_object_file) { "app/form_objects/user_create.rb" }
    let(:spec_file) { "spec/form_objects/user_create_spec.rb" }

    it "creates a form_object file" do
      assert_file form_object_file
    end

    it "creates a spec file" do
      assert_file spec_file
    end
  end

  context "with parent class option" do
    let(:options) { '--parent=Foo::Bar' }

    specify "should have directory structure" do
      destination_root.should have_structure {
        directory "app" do
          directory "form_objects" do
            file "user_create.rb" do
              contains load_from_file("user_create_with_parent.txt")
            end
          end
        end
      }
    end
  end

  context "with namespace" do
    let(:name) { "xyz::user" }

    specify "should have directory structure" do
      destination_root.should have_structure {
        directory "app" do
          directory "form_objects" do
            directory "xyz" do
              file "user_create.rb" do
                contains load_from_file("user_create_with_namespace.txt")
              end
            end
          end
        end
      }
    end

    specify "spec directory structure" do
      destination_root.should have_structure {
        directory "spec" do
          directory "form_objects" do
            directory "xyz" do
              file "user_create_spec.rb" do
                contains load_from_file("user_create_with_namespace_spec.txt")
              end
            end
          end
        end
      }
    end
  end
end

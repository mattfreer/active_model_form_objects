require 'spec_helper'

describe ActiveModel::FormObject::Validators::PermittedParamsValidator do
  subject { described_class.new(:attributes => {:foo => :bar}) }

  let(:user) { double(:user) }

  let(:form_object) { mock_model("FormObject", :user => user, :unpermitted_attrs => []) }

  describe "#validate_each" do
    it "record should receive unpermitted_attrs" do
      expect(form_object).to receive('unpermitted_attrs')
      subject.validate_each(form_object, "user", nil)
    end

    context "when unpermitted_attrs exist" do
      before(:each) do
        allow(form_object).to receive(:unpermitted_attrs).and_return({:user => [:email, :age]})
      end

      it "should add errors to record" do
        subject.validate_each(form_object, "user", nil)
        expect(form_object.errors).to include(:user)
        expect(form_object.errors[:user]).to include("email is not permitted")
        expect(form_object.errors[:user]).to include("age is not permitted")
      end
    end

    context "when unpermitted_attrs don't exist" do
      before(:each) do
        allow(form_object).to receive(:unpermitted_attrs).and_return([])
      end

      it "should not add errors to record" do
        subject.validate_each(form_object, "user", nil)
        expect(form_object.errors).to be_empty
      end
    end
  end
end

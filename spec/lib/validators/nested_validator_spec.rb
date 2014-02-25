require 'spec_helper'
require 'active_model/form_object/validators/nested_validator'

describe ActiveModel::FormObject::Validators::NestedValidator do
  subject { described_class.new(:attributes => {:foo => :bar}) }

  let(:user) do
    u = mock_model('User')
    allow(u).to receive(:valid?)
    u
  end

  let(:model_instance) do
    m = mock_model('UserRegistration', :user => user)
    allow(m).to receive(:errors).and_return({})
    m
  end

  describe "#validate_each" do
    it "should send #valid? to nested resource" do
      expect(user).to receive('valid?')
      subject.validate_each(model_instance, "user", user)
    end
  end

  context "when nested resource is invalid" do
    before(:each) do
      allow(user).to receive(:valid?).and_return(false)
      allow(user).to receive(:errors).and_return({:name => "to short", :email => "invalid"})
    end

    describe "#errors" do
      it "should include nested resource errors" do
        expect(model_instance).to receive('errors')
        subject.validate_each(model_instance, "user", user)
        expect(model_instance.errors.count).to eql(2)
        expect(model_instance.errors.has_key?(:name)).to eql(true)
        expect(model_instance.errors.has_key?(:email)).to eql(true)
      end
    end
  end
end

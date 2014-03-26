require 'spec_helper'
require 'active_model/form_object/strong_parameters'

describe "ActiveModel::FormObject::StrongParameters" do

  class StrongParametersTester
    include ActiveModel::FormObject::StrongParameters

    strong_parameters :user => [:name, :email]
  end

  describe "class methods" do
    it "adds the #strong_parameters method" do
      expect(StrongParametersTester.respond_to?(:strong_parameters)).to eql(true)
    end
  end

  describe "instance methods" do
    it "adds the :key_params instance method" do
      expect(StrongParametersTester.new.respond_to?(:user_params)).to eql(true)
    end
  end

  describe ActiveModel::FormObject::StrongParameters::StrongParameters do
    let(:user_params) { ActionController::Parameters.new(:user => {:name => "Matt Freer", :email => "matt.freer@gmail.com"}) }

    class MockFormObject
      attr_accessor :params, :unpermitted_attrs

      def initialize(attr)
        @params = attr
      end
    end

    subject { described_class.new(MockFormObject) }

    describe "#initialize" do
      it "sets its klass to the Form Object" do
        expect(subject.klass).to eql(MockFormObject)
      end
    end

    let(:form_obj) { MockFormObject.new(user_params) }

    describe "#set" do
      it "defines a method on the Form Object" do
        subject.set(:params, {:user => [:name, :email] })
        expect(form_obj.respond_to?(:user_params)).to eql(true)
      end
    end

    context "when a #user_params method has been defined on the Form Object" do
      before(:each) do
        subject.set(:params, {:user => [:name, :email] })
      end

      it "when sending the #user_params message to the Form Object then the form_object#params object will receive #require and #permit" do
        expect(user_params).to receive(:require).with(:user).and_return(user_params)
        expect(user_params).to receive(:permit).with([:name, :email]).and_return(user_params)
        form_obj.user_params
      end
    end
  end
end

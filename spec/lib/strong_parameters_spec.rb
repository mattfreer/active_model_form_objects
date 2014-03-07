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

    describe "#initialize" do

      it "sets its klass to a class" do
        klass = StrongParametersTester
        expect(described_class.new(klass).klass).to eql(klass)
      end

    end

    describe "#set" do

      class StrongParametersClassTester

        attr_accessor :required, :permitted

        def [](key)
          true
        end

        def my_params
          return self
        end

        def require(args)
          @required = args
          return self
        end

        def permit(args)
          @permitted = args
          return self
        end
      end

      before(:each) do
        strong_params = described_class.new(StrongParametersClassTester)
        strong_params.set(:my_params, {:admin => [:email, :name] })
      end

      it "defines a method on the defined class" do
        expect(StrongParametersClassTester.new.respond_to?(:admin_params)).to eql(true)
      end

      it "calls the method which calls #require and #permit on the parameter name" do
        tester = StrongParametersClassTester.new
        tester.admin_params
        expect(tester.required).to eql(:admin)
        expect(tester.permitted).to eql([:email, :name])
      end

      it "doesn't call the method when the parameter is missing" do
        tester = StrongParametersClassTester.new
        allow(tester).to receive(:[]).and_return(nil)
        tester.admin_params
        expect(tester.required).to eql(nil)
        expect(tester.permitted).to eql(nil)
      end

    end
  end

end

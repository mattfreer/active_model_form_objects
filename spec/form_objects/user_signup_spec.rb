require 'spec_helper'

describe UserSignup do
  subject { described_class.new(attrs) }
  let(:attrs) { {:params => user_params } }
  let(:user_params) { nil }

  it_behaves_like "a form_object"

  describe "#valid?" do
    it "triggers #create_user callback" do
      expect(subject).to receive(:create_user)
      subject.valid?()
    end
  end

  context "with attributes" do
    let(:attrs) { {:foo => :bar} }

    describe "#foo" do
      it "should be bar" do
        expect(subject.foo).to be :bar
      end
    end
  end

  context "with valid attributes" do
    let(:user_params) do
      ActionController::Parameters.new(:user => {
        :name => "Matt Freer",
      })
    end

    it "should be valid" do
      expect(subject.valid?).to eql true
    end
  end

  context "with unpermitted params" do
    let(:user_params) do
      ActionController::Parameters.new(:user => {
        :name => "Matt Freer",
        :email => "matt.freer"
      })
    end

    it "should be invalid" do
      expect(subject.valid?).to eql false
      expect(subject.errors).to include(:user)
      expect(subject.errors[:user]).to include("email is not permitted")
    end

    it "sending #user_params message should populate unpermitted paramaters" do
      subject.user_params
      expect(subject.unpermitted_attrs).to include(:user)
    end
  end
end

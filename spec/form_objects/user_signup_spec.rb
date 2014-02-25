require 'spec_helper'

describe UserSignup do
  subject { described_class.new(attrs) }
  let(:attrs) {}

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
end

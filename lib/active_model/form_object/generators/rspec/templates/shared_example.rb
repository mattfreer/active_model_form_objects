require 'spec_helper'

shared_examples 'a form_object' do
  describe "#persisted?" do
    it "should be false" do
      expect(subject.persisted?).to eq false
    end
  end

  describe ".model_name" do
    it "should be instance of ActiveModel::Name" do
      expect(subject.class.model_name).to be_an_instance_of ActiveModel::Name
    end
  end

  context "when valid" do
    before(:each) do
      allow(subject).to receive(:valid?).and_return(true)
    end

    it "should receive #persist!" do
      expect(subject).to receive(:persist!)
      subject.save
    end

    it "#save returns true" do
      allow(subject).to receive(:persist!).and_return(true)
      expect(subject.save).to eq(true)
    end
  end

  context "when invalid" do
    before(:each) do
      allow(subject).to receive(:valid?).and_return(false)
    end

    it "shouldn't receive #persist!" do
      expect(subject).not_to receive(:persist!)
      subject.save
    end

    it "#save returns false" do
      expect(subject.save).to eq false
    end
  end
end

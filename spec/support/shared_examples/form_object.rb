require 'spec_helper'

shared_examples 'a form_object' do
  its(:persisted?) { should be_false }

  describe ".model_name" do
    it "should be instance of ActiveModel::Name" do
      subject.class.model_name.should be_an_instance_of ActiveModel::Name
    end
  end

  context "when valid" do
    before(:each) do
      subject.stub(:valid?).and_return(true)
    end

    it "should receive #persist!" do
      subject.should_receive(:persist!)
      subject.save
    end

    it "#save returns true" do
      subject.stub(:persist!).and_return(true)
      subject.save.should be_true
    end
  end

  context "when invalid" do
    before(:each) do
      subject.stub(:valid?).and_return(false)
    end

    it "shouldn't receive #persist!" do
      subject.should_not_receive(:persist!)
      subject.save
    end

    it "#save returns false" do
      subject.save.should be_false
    end
  end
end

require "test_helper"

describe <%= "#{klass_name}" %> do
  before do
    @subject = <%= "#{ klass_name }" %>.new
  end

  describe "#foo" do
    it "responds to #save" do
      @subject.must_respond_to :save
    end
  end
end

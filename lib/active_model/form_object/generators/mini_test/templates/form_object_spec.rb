require "minitest/autorun"

describe <%= "#{klass_name}" %> do
  before do
    @subject = klass_name.new
  end

  describe "#foo" do
    #it "tests the truth" do
      @subject.foo.must_equal "bar"
    #end
  end
end

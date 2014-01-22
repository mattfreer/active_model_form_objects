require "minitest/autorun"

class <%= "#{klass_name}" %> < Minitest::Test
  def setup
    @subject = klass_name.new
  end

  #def test_the_truth
    #assert_equal "bar", @subject.foo
  #end
end

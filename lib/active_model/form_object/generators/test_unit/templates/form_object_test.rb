require 'test_helper'

class <%= "Test#{klass_name}" %> < ActiveSupport::TestCase
  def setup
    @subject = <%= "#{ klass_name }" %>.new
  end

  def test_for_save
    assert_respond_to @subject, :save
  end
end

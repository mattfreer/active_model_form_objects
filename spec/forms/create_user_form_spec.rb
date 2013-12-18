require 'spec_helper'

describe CreateUserForm do
  subject { described_class.new }

  it_behaves_like "a form_object"
end

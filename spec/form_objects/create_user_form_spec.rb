require 'spec_helper'

describe CreateUserForm do
  subject { described_class.new(attrs) }
  let(:attrs) {}

  it_behaves_like "a form_object"

  context "with attributes" do
    let(:attrs) { {:foo => :bar} }
    its(:foo) { should be :bar }
  end
end

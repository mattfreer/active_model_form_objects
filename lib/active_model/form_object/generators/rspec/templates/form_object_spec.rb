require 'spec_helper'

describe <%= "#{klass_name}" %> do
  subject { described_class.new(attrs) }
  let(:attrs) {}

  it_behaves_like "a form_object"
end

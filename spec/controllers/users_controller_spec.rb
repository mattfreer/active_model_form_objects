require 'spec_helper'

describe UsersController do

  describe "GET 'signup'" do
    it "returns http success" do
      get 'signup'
      expect(response).to be_success
    end
  end

end

require 'active_model'

class UserSignup
  include ActiveModel::FormObject

  attr_accessor :name
  attr_reader :user

  validates :name, :length => { :minimum => 2 }

  def self.model_name
    ActiveModel::Name.new(self, nil, "User")
  end

  def persist!
    @user = User.create!(:name => name)
  end
end

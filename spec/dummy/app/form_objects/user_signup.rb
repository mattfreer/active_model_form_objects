require 'active_model'

class UserSignup
  include ActiveModel::FormObject

  attr_accessor :name
  attr_reader :user

  validates :name, :length => { :minimum => 5 }
  validates :user, :nested => true

  before_validation :create_user

  strong_parameters :user => [:name]

  private

  def create_user
    @user = User.new(user_params)
    @name = user_params[:name]
  end

  def persist!
    user.save!
  end
end

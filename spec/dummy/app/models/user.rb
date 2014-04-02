class User < ActiveRecord::Base
  validates :name, :format => { :with => /\A[A-z\s]+\z/ }

end

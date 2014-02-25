require "active_model/form_object/validators/nested_validator"

class User < ActiveRecord::Base
  validates :name, :format => { :with => /\A[A-z\s]+\z/ }
end

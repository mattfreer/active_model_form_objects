class UsersController < ApplicationController
  def signup
    @signup_form = UserSignup.new
  end

  def create
    @signup_form = UserSignup.new(:params => params)
    if @signup_form.save
      @user = @signup_form.user
      render "create"
    else
      render "signup"
    end
  end
end

class UsersController < ApplicationController
  respond_to :html

  def signup
    @signup_form = UserSignup.new
  end

  def create
    @signup_form = UserSignup.new(:params => params)
    if @signup_form.save
      @user = @signup_form.user
      respond_with @user
    else
      render "signup"
    end
  end
end

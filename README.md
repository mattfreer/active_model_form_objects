# ActiveModel::FormObjects

[![Build Status](https://travis-ci.org/mattfreer/active_model_form_objects.png)](https://travis-ci.org/mattfreer/active_model_form_objects)
[![Coverage Status](https://coveralls.io/repos/mattfreer/active_model_form_objects/badge.png?branch=master)](https://coveralls.io/r/mattfreer/active_model_form_objects?branch=master)

This Gem provides an `ActiveModel::FormObject` module that can be included into a PORO. Includes a Rails Generator for Form Objects.

Form Objects are used to encapsulate operations which are triggered by a form submission. They are particularly useful when multiple Models need to be updated by a single form submission. A common example would be a signup form that results in the creation of both a Company and a User.

##Install

In your Gemfile
```ruby
gem 'active_model_form_objects'
```
And then execute:
````bash
$ bundle
````

## Creating a FormObject with the Generator
The following example generates a `UserLogin` form-object (and test).
```bash
$ rails generate active_model:form_object user login
```

The test framework your project uses will determine the type of test created:
* For RSpec it creates:
 * Form-object:  app/form_objects/user_login.rb
 * Test:         spec/form_objects/user_login_spec.rb

* For MiniTest it creates:
 * Form-object:  app/form_objects/user_login.rb
 * Test:         test/form_objects/user_login_test.rb

* For TestUnit it creates:
 * Form-object:  app/form_objects/user_login.rb
 * Test:         test/unit/form_objects/user_login_test.rb

## User Signup Example
The following example demonstrates a user signup form-object and how this would be intergrated with a form.

* Points of interest:
 * The use of the `before_validation` callback hook.
 * The use of the NestedValidator to run any existing validations defined on the `User` model.
 * The use of the [strong_parameters](#strong-parameters) method on the form object instead of defining it in the controller

#### user_signup.rb:
```ruby
require 'active_model'

class UserSignup
  include ActiveModel::FormObject

  attr_reader :user

  validates :name, :length => { :minimum => 5 }
  validates :user, :nested => true

  before_validation :create_user

  strong_parameters :user => [:name]

  private

  def create_user
    @user = User.new(user_params)
  end

  def persist!
    user.save!
  end
end
```

#### users_controller.rb:
```ruby
class UsersController < ApplicationController
  respond_to :html

  def signup
    @signup_form = UserSignup.new
  end

  def create
    @signup_form = UserSignup.new(:params => params)
    if @signup_form.save()
      @user = @signup_form.user
      respond_with @user
    else
      render "signup"
    end
  end
end

```

#### signup.html.erb:
```ruby
<h1>Users#signup</h1>

<%= form_for @signup_form do |f| %>
  <%= f.text_field :name %>
  <%= f.submit "Submit" %>
<% end %>
```

## Strong Parameters

In rails 4 the [strong_parameters](https://github.com/rails/strong_parameters) gem is used as a method of protecting the attributes that can be passed through in the creation of a model. The usual way of doing this is defining a method on your controller:

```ruby

class UsersController < ApplicationController

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end

```

With The `ActiveModel::FormObject::StrongParameters` module this can now be defined in your form object using the `strong_parameters` class method. The following is the Form Object version of the `user_params` method above:

```ruby

  class UserRegister
    include ActiveModel::FormObject

    strong_paramters :user => [:name, :email]
  end

```

The default implementation assumes a `params` method on the FormObject which can be defined in the controller as:

```ruby

  UserRegister.new(:params => params)

```

If you wish to change the name of the params method to something else such as `my_params` then the `strong_paramters` method can be called with `:my_params` as an argument:

```ruby

    strong_paramters, :my_params, :user => [:name, :email]

```

In your controller you can now do:

```ruby

  UserRegister.new(:my_params => params)

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
This project rocks and uses MIT-LICENSE.

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

## Creaing a FormObject with the Generator
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

#### user_signup.rb:
```ruby
require 'active_model'

class UserSignup
  include ActiveModel::FormObject

  attr_accessor :name
  attr_reader :user

  validates :name, :length => { :minimum => 10 }

  private

  def persist!
    @user = User.create!(:name => name)
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
    @signup_form = UserSignup.new(params[:user])
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
This project rocks and uses MIT-LICENSE.

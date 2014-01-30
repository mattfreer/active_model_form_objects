= ActiveModelFormObjects

This Gem provides an ActiveModel::FormObject module that can be included into a PORO. A Rails Generator for Form Objects is included in the Gem.

Form Objects are used to encapsulate operations which are triggered by a form submission. They are particularly useful when multiple Models need to be updated by a single form submission. A common example would be a signup form that results in the creation of both a Company and a User.

== Generator Example

The following example generates a `UserLogin` form-object (and test).
```bash
$ rails generate active_model:form_object user login
```
The test framework your project uses will determine the type of test created:
*For RSpec it creates:
 *Form-object:  app/form_objects/user_login.rb
 *Test:         spec/form_objects/user_login_spec.rb

For MiniTest it creates:
 *Form-object:  app/form_objects/user_login.rb
 *Test:         test/form_objects/user_login_test.rb

*For TestUnit it creates:
 *Form-object:  app/form_objects/user_login.rb
 *Test:         test/unit/form_objects/user_login_test.rb

==Install

In your Gemfile
```bash
gem 'ignore_default_scope', :git => 'git://github.com/mattfreer/ignore_default_scope.git'
```

And then execute:
````bash
$ bundle
````
== Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
This project rocks and uses MIT-LICENSE.

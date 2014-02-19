Feature: User Signup
  In order to signup as a User
  I want to submit the signup form
  And see a welcome message

  Scenario:
    Given I go to the signup page
    When I fill in "user_name" with "Matt Freer"
    And I click button "Submit"
    Then the page has content "Welcome Matt Freer"



Given /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I click button "([^"]*)"$/ do |value|
  click_on( value )
end

Then /^the page has content "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

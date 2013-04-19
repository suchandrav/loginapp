# Singup
When /^I go to signup page$/ do
  page = MockServicePage.new @browser
  page.click_signup_button
end
When /^I go to preprod signup page$/ do
  page = MockServicePage_pp.new @browser
  page.click_signup_button
end
When /^I signup with '(.*)' as number$/ do  |msisdn|
  data = UserData.new
  msisdn = data.get_msisdn msisdn
  page = GroupSignupEnterMsisdnPage.new @browser
  page.enter_msisdn msisdn
  page.click_submit_button
end
Then /^I see Please check your phone now$/ do
  page = GroupMsisdnSignupDetailsPage.new @browser
  assert_equal('Please check your phone now', page.get_header.text)
end
Then /^I enter sms code with '(.*)'$/ do  |code|
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.enter_code code
end
Then /^I enter email address with '(.*)'$/ do  |email|
  data = UserData.new
  email = data.get_email email
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.enter_email email
end
Then /^I enter password with '(.*)'$/ do  |password|
  data = UserData.new
  password = data.get_password password
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.enter_password password
end
Then /^I confirm password with '(.*)'$/ do  |password|
  data = UserData.new
  password = data.get_password password
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.enter_password_confirm password
end
Then /^I accept the terms and condition$/ do
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.click_tnc_checkbox
end
Then /^I click show password$/ do
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.click_show_password_checkbox
end
Then /^I submit$/ do
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.click_submit_button
end
Then /^I cancel sign up$/ do
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.click_cancel_button
end

When /^I signup to ES with '(.*)' as number and (.*) as email$/ do  |msisdn, email|
  data = UserData.new
  email = data.get_email email
  msisdn = data.get_msisdn msisdn
  page = ESSignupPage.new @browser
  page.enter_msisdn msisdn
  page.enter_email email
  page.click_tnc_checkbox
  page.click_submit_button
end

Then /^I see Signup empty fields failure message$/ do
  page = GroupMsisdnLoginPage.new @browser
  assert_equal('Please enter the SMS code.', page.get_error_messages[0].text)
  assert_equal('Please enter a valid email address.', page.get_error_messages[1].text)
  assert_equal('Please enter a valid password.', page.get_error_messages[2].text)
  assert_equal('Please confirm your password.', page.get_error_messages[3].text)
end

When /^I click on Reset password$/ do
  page = MockServicePage.new @browser
  page.click_reset_password_button
end

When /^I reset password with '(.*)' as user name$/ do |username|
  data = UserData.new
  username = data.get_email(data.get_msisdn (username))
  page = GroupResetPasswordPage.new @browser
  page.enter_username username
  page.click_reset_button
end

Then /^I see Reset empty field failure message$/ do
  page = GroupResetPasswordPage.new @browser
  assert_equal('Please enter your mobile number.', page.get_error_messages[0].text)
end

Then /^I see Reset password confirmation$/ do
  page = AfterResetPasswordPage.new @browser
  assert_equal('Reset Password', page.get_header.text)
end

When /^I click on OK button$/ do
  page = GroupResetPasswordPage.new @browser
  page.click_OK_password_button
end

Then /^I see mock page after my password was reset$/ do
  page = MockServicePage.new @browser
end

When /^I go to reset password page$/ do
  page = MockServicePage.new @browser
  page.click_reset_password_button
end


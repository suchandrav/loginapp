When /^I click on My account$/ do
  page = MockServicePage.new @browser
  page.click_my_account_button
end

When /^I click on Logout$/ do
  page = MockServicePage.new @browser
  page.click_logout_button
end

Then /^I see a page with a headline that says '(.*)'$/ do |msg|
  assert_equal(msg, @browser.h3(:class => 'formHeading').text)
end

When /^I click the change password link$/ do
  page = GroupMyAccountPage.new @browser
  page.click_change_password
  sleep 10
end

When /^I click the update email button$/ do
  page = GroupMyAccountPage.new @browser
  page.click_change_email
  @browser.h3(:text, 'Update email address').wait_until_present
end

When /^I enter a new email '(.*)'$/ do |new_email|
  data = UserData.new
  new_email = data.get_email new_email
  page = GroupMyAccountPage.new @browser
  page.enter_new_email new_email
end
When /^I enter my current password with '(.*)'$/ do |password_input|
  data = UserData.new
  password_input = data.get_password password_input
  page = GroupMyAccountPage.new @browser
  page.enter_current_password password_input
end
When /^I click submit new email$/ do
  page = GroupMyAccountPage.new @browser
  page.click_submit_new_email_button
end
When /^I click new email$/ do
  page = GroupMyAccountPage.new @browser
  page.click_submit_new_email_button
  sleep 5
end

When /^I enter a new password with '(.*)'$/ do |new_password|
  data = UserData.new
  new_password = data.get_password new_password
  page = GroupMyAccountPage.new @browser
  page.enter_new_password new_password
end
When /^I confirm my new password with '(.*)'$/ do |new_password|
  data = UserData.new
  new_password = data.get_password new_password
  page = GroupMyAccountPage.new @browser
  page.enter_confirm_new_password new_password
end
When /^I click submit new password$/ do
  page = GroupMyAccountPage.new @browser
  page.click_submit_new_password_button
end
When /^I click the back button on the my account page$/ do
  page = GroupMyAccountPage.new @browser
  page.click_back_button
end

When /^I click on verify Email with '(.*)'$/ do  |email|
  data = UserData.new
  email = data.get_email email
  page = MockServicePage.new @browser
  page.enter_email email
  page.click_verify_email_button
end

Then /^I see Email verification success message '(.*)'$/ do |msg|
  assert_equal(msg, @browser.h3(:class => 'spec_panelHeaderTitle').text)
end

Then /^I see the text '(.*)' in the popup$/ do |text|
  assert(@browser.span(:class => 'feedbackPanelERROR').text.include?(text), "The text '#{text}' wasn't found in the popup.")
end

When /^I click on verify MSISDN with '(.*)'$/ do  |number|
  data = UserData.new
  number = data.get_msisdn number
  page = MockServicePage.new @browser
  page.enter_msisdn number
  page.click_verify_msisdn_button
end

Then /^I see MSISDN verification success message '(.*)'$/ do |msg|
  assert( @browser.h3(:class => 'spec_panelHeaderTitle').text== msg )
end

Then /^I click the OK button in the Password changed dialog$/ do 
  page = GroupMyAccountPage.new @browser
  page.click_ok_button_password_changed
end

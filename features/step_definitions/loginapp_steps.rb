require 'watir-webdriver'
require 'test/unit'
include Test::Unit::Assertions
require 'net/http'

Then /^I take a screenshot$/ do
  embed_screenshot (take_screenshot(@browser, screenshot_filename_from_scenario_name))
end

Given /^I open '(.*)' site for the opco '(.*)'$/ do |app, opco|
  page = MockServicePage.new @browser
  page.visit opco, app
end

Given /^I open '(.*)' site for the opco '(.*)' in a logged out state$/ do |app, opco|
  page = MockServicePage.new @browser
  page.visit opco, app
  if page.get_info_messages[0].text== 'Global cookie present.'
    page.click_logout_button
  end
  assert_equal(0, page.get_info_messages.size)
end

Given /^I open '(.*)' preprod site for the opco '(.*)' in a logged out state$/ do |app, opco|
  page = MockServicePage_pp.new @browser
  page.visit opco, app
  if page.get_info_messages[0].text== 'Global cookie present.'
    page.click_logout_button
  end
  assert_equal(0, page.get_info_messages.size)
end

When /^I go to login page$/ do
  page = MockServicePage.new @browser
  page.click_login_button
end

When /^I login with '(.*)' as user name and '(.*)' as password$/ do |username, password|
  data = UserData.new
  username = data.get_email(data.get_msisdn (username))
  password = data.get_password password
  page = GroupMsisdnLoginPage.new @browser
  page.enter_username username
  page.enter_password password
  page.click_login_button
end

Given /^I'm logged in with a group account to '(.*)' for the opco '(.*)', with credentials '(.*)' '(.*)'$/ do |service, opco, username, password|
  data = UserData.new
  username = data.get_email(data.get_msisdn (username))
  password = data.get_password password
  page = MockServicePage.new @browser
  page.visit opco, service
  if page.get_info_messages[0].text== 'Global cookie present.'
    page.click_logout_button
  end
  page.click_login_button
  page = GroupMsisdnLoginPage.new @browser
  page.enter_username username
  page.enter_password password
  page.click_login_button
  page = MockServicePage.new @browser
  assert_equal('Global cookie present.', page.get_info_messages[0].text)
end

Given /^I login with a brand new group account to '(.*)' for the opco '(.*)', with MSISDN='\+?(.*)', password='(.*)' and email='(.*)'$/ do |service, opco, msisdn, password, email|
  data = UserData.new
  email = data.get_email email
  msisdn = data.get_msisdn msisdn
  password = data.get_password password
  #resp_code = purge_delete_all_accounts_msisdn msisdn
  #assert_equal('200', resp_code, "deleting accounts failed for msisdn #{msisdn}")
  #resp_code = purge_delete_account_username email
  #assert_equal('200', resp_code, "deleting account failed for email #{email}")
  page = MockServicePage.new @browser
  page.visit opco, service
  if page.get_info_messages[0].text== 'Global cookie present.'
    page.click_logout_button
  end
  page.click_signup_button
  page = GroupSignupEnterMsisdnPage.new @browser
  page.enter_msisdn "+#{msisdn}"
  page.click_submit_button
  page = GroupMsisdnSignupDetailsPage.new @browser
  page.enter_code 'magic'
  page.enter_email email
  page.enter_password password
  page.enter_password_confirm password
  page.click_tnc_checkbox
  page.click_submit_button
  page = MockServicePage.new @browser
  assert_equal('Global cookie present.', page.get_info_messages[0].text)
end


Then /^I see login cookie present$/ do
  page = MockServicePage.new @browser
  assert_equal('Global cookie present.', page.get_info_messages[0].text)
end

Then /^I see preprod login cookie present$/ do
  page = MockServicePage_pp.new @browser
  assert_equal('Global cookie present.', page.get_info_messages[0].text)
end

Then /^I see login cookie not present$/ do
  page = MockServicePage.new @browser
  assert_equal(0, page.get_info_messages.size)
end


Then /^I should not see login cookie present$/ do
  page = MockServicePage.new @browser
  assert_equal(0, page.get_info_messages.length)
end

Then /^I see login failure message$/ do
  page = GroupMsisdnLoginPage.new @browser
  assert_equal('Either your email / mobile or password was entered incorrectly. Please try again.', page.get_error_messages[0].text)
end

Then /^I see PT login failure message$/ do
  page = GroupMsisdnLoginPage.new @browser
  assert_equal('Incorrect password or number. Please try again.', page.get_error_messages[0].text)
end

Then /^I see ES login failure message$/ do
  page = GroupMsisdnLoginPage.new @browser
  assert_equal('Incorrect password or number. Please try again.', page.get_error_messages[0].text)
end

Then /^I see Login empty fields failure message$/ do
  page = GroupMsisdnLoginPage.new @browser
  assert_equal('Please enter your email address or mobile number.', page.get_error_messages[0].text)
  assert_equal('Please enter your password.', page.get_error_messages[1].text)
end

Then /^I see not supported failure message$/ do
  page = NotSupportedErrorPage.new @browser
  assert_equal("We're sorry, but the service is not supported in your country.", page.get_error_message)
end


When /^I go to Oops page$/ do
  page = MockServicePage.new @browser
  page.visit_oops
end

When /^I go to 404 page$/ do
  page = MockServicePage.new @browser
  page.visit_404
end

When /^I click logout$/ do
  page = MockServicePage.new @browser
  page.click_logout_button
end

When /^I click logout if necessary$/ do
  page = MockServicePage.new @browser
  if page.get_info_messages[0].text== 'Global cookie present.'
    page.click_logout_button
  end
end

Given /^I clear the cookies and reload the page$/ do
  @browser.cookies.clear
  @browser.refresh
end

Given /^I clear ALL the cookies in the browser$/ do
#  @browser.send_keys [:control, 't']
  @browser.goto 'chrome://chrome/settings/clearBrowserData'
  unless @browser.input(:id => 'delete-cookies-checkbox').checked?
    @browser.input(:id => 'delete-cookies-checkbox').click
  end
  @browser.button(:id => 'clear-browser-data-commit').click
#  sleep 5
#  @browser.send_keys [:control, 'w']
#  @browser.refresh
end



Given /^I close the browser and open a new one with accept-language '(.*)'$/ do |lang|
  @browser.close
  @browser = get_browser(lang, true)
end




Given /^I purge delete accounts with MSISDN '\+?(.*)' verified$/ do |msisdn|
  data = UserData.new
  msisdn = data.get_msisdn msisdn
  resp_code = purge_delete_account_msisdn msisdn
  assert_equal('200',resp_code)
  sleep 5
end

Given /^I purge delete all accounts with MSISDN '\+?(.*)'/ do |msisdn|
  data = UserData.new
  msisdn = data.get_msisdn msisdn
  resp_code = purge_delete_all_accounts_msisdn msisdn
  assert_equal('200',resp_code)
  sleep 5
end



Given /^I purge delete accounts with username '(.*)'$/ do |email|
  data = UserData.new
  email = data.get_email email
  resp_code = purge_delete_account_username email
  assert_equal('200',resp_code)
  sleep 5
end


Then /^I see a message page that says '(.*)'/ do |text|
  page = MessagePage.new @browser
  assert_equal(text, page.get_message)
end

Then /^I click the '(.*)' button in the message page/ do |button_text|
  page = MessagePage.new @browser
  page.click_button button_text
end

Then /^I login to ES with '(.*)' as user name and '(.*)' as password/ do |username_input, password|
  data = UserData.new
  username_input = data.get_msisdn username_input
  password = data.get_password password
  page = ESLoginPage.new @browser
  page.enter_username username_input
  page.enter_password password
  page.click_login_button
end

When /^I login to PT with '(.*)' as user name and '(.*)' as password$/ do |username_input, password|
  data = UserData.new
  username_input = data.get_msisdn username_input
  password = data.get_password password
  page = PTLoginPage.new @browser
  page.enter_username username_input
  page.enter_password password
  page.click_login_button
end

When /^I login to NL with '(.*)' as user name and '(.*)' as password$/ do |username, password|
  data = UserData.new
  username = data.get_msisdn username
  password = data.get_password password
  page = NLLoginPage.new @browser
  page.enter_username username
  page.enter_password password
  page.click_login_button
end

When /^I login to DE with '(.*)' as user name and '(.*)' as password$/ do |username, password|
  data = UserData.new
  username = data.get_msisdn username
  password = data.get_password password
  page = DELoginPage.new @browser
  page.enter_username username
  page.enter_password password
  page.click_login_button
end

Then /^I check I am in the add email page$/ do
  page = PostLoginEmailPage.new @browser
  assert_equal('Your email is not set', page.get_header_text)
end

Then /^I add my email '(.*)' because the account lacks an email address$/ do |email|
  data = UserData.new
  email = data.get_email email
  page = PostLoginEmailPage.new @browser
  page.enter_email email
  page.click_submit_button
end

Then /^I save the username '(.*)' to delete the account later/ do |username|
  if username == 'last_random_example_email'
    username = @last_random_example_email
  end
  @username_to_delete = username
end

Then /^I save the msisdn '(.*)' to delete the account later/ do |msisdn|
  if msisdn == 'last_random_msisdn'
    msisdn = @last_random_msisdn
  end
  @msisdn_to_delete = msisdn
end

Then /^I wait '(.*)' seconds/ do |seconds|
  sleep seconds.to_i
end

When /^I open the version page$/ do
  @browser.goto 'https://dit.vfglogin.vodafone.com/version'
end

Then /^I see the text '(.*)' anywhere in the page$/ do |text|
#  assert(@browser.text.include?(text), "The text '#{text}' wasn't found on the page.")
  assert(@browser.text.include?(text), "The text #{text} wasn't found on the page.")
end

Then /^I do not see the text '(.*)' anywhere in the page$/ do |text|
  assert(!@browser.text.include?(text), "The text #{text} was found on the page.")
end

When /^I delete all the cookies in all domains$/ do
  clear_cookies_with_extension
end
When /^I enter '(.*)' in the password field$/ do |password|
  page = GroupMsisdnLoginPage.new @browser
  page.enter_password password
end

Given /^I generate the next correlative email address$/ do
  data = UserData.new
  data.generate_next_email
end

Given /^I generate the next correlative msisdn$/ do
  data = UserData.new
  data.generate_next_msisdn
end

Given /^I generate the next correlative ES msisdn$/ do
  data = UserData.new
  data.generate_next_ES_msisdn
end


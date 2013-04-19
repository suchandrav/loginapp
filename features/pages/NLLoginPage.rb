class NLLoginPage
  def initialize(browser)
    @browser = browser
  end

  def enter_username(username)
    @browser.text_field(:id => 'username').set username
  end

  def enter_password(password)
    @browser.text_field(:id => 'password').set password
  end

  def click_login_button
    @browser.a(:id => 'inloggen').click
  end

  def get_error_messages
    @browser.div(:id => 'contactformMsgHead').spans
  end
end
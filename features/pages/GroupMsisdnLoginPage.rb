class GroupMsisdnLoginPage
  def initialize(browser)
    @browser = browser
  end

  def enter_username(username)
    @browser.text_field(:name => 'username').set username
  end

  def enter_password(password)
    @browser.text_field(:type => 'password').set password
  end

  def click_login_button
    @browser.button(:type => 'submit').click
  end

  def get_error_messages
    @browser.spans(:class => 'feedbackPanelERROR')
  end
end
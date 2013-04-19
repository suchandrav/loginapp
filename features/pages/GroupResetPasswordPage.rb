class GroupResetPasswordPage
  def initialize(browser)
    @browser = browser
  end

  def enter_msisdn(username)
    @browser.text_field(:name => 'phone').set username
  end

  def click_reset_button
    @browser.button(:type => 'submit').click
  end

  def get_error_messages
    @browser.spans(:class => 'feedbackPanelERROR')
  end
end
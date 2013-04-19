class AfterResetPasswordPage
  def initialize(browser)
    @browser = browser
  end

  def click_ok_button
    @browser.button(:type => 'submit').click
  end

end
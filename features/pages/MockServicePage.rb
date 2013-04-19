class MockServicePage
  def initialize(browser)
    @browser = browser
  end

  def visit(opco, service)
    @browser.goto 'https://dit.vfglogin.vodafone.com/mock'
    opco = opco.upcase
    service = service.downcase
    if(service == 'kids')
      @browser.goto 'https://dit.vfglogin.vodafone.es/mock/kids?opco=es&service=kids&channel=mobile'
    else
      @browser.span(:text, "(#{opco}) #{service}").click
    end
  end

  def click_login_button
    @browser.input(:name => 'loginSubmit').click
  end

  def click_logout_button
    @browser.input(:name => 'logoutSubmit').click
  end

  def click_my_account_button
    @browser.input(:name => 'myAccountSubmit').click
  end

  def click_signup_button
    @browser.input(:name => 'signupSubmit').click
  end

  def click_reset_password_button
    @browser.input(:name => 'resetpwdSubmit').click
  end


  def enter_email(email)
    @browser.text_field(:name, "email").set email
  end

  def click_verify_email_button
    @browser.input(:name => 'verifyEmailSubmit').click
  end

  def enter_msisdn(msisdn)
    @browser.text_field(:name, "number").set msisdn
  end

  def click_verify_msisdn_button
    @browser.input(:name => 'verifyMsisdnSubmit').click
  end

  def get_info_messages
    @browser.spans(:class => 'feedbackPanelINFO')
  end

  def visit_oops
    @browser.goto 'https://dit.vfglogin.vodafone.com/login'
  end

  def visit_404
    @browser.goto 'https://dit.vfglogin.vodafone.com/thispagedoesntexist'
  end

end
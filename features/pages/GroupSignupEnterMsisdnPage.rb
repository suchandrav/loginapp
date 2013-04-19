class GroupSignupEnterMsisdnPage
  def initialize(browser)
    @browser = browser
  end

  def enter_msisdn(msisdn)
    @browser.text_field(:name => 'phoneBlock:phone').set msisdn
  end

  def click_submit_button
    @browser.button(:type => 'submit').click
  end

  def get_error_messages
    @browser.spans(:class => 'feedbackPanelERROR')
  end
end
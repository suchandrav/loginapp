class PostLoginEmailPage
  def initialize(browser)
    @browser = browser
  end

  def enter_email(email)
    @browser.text_field(:name => 'email').set email
  end

  def click_submit_button
    @browser.button(:type => 'submit').click
  end

  def get_error_messages
    @browser.spans(:class => 'feedbackPanelERROR')
  end

  def get_header_text
    @browser.div(:id=>'details').h3(:class=>'formHeading').text
  end
end
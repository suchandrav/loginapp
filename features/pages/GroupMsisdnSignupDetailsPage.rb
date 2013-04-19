class GroupMsisdnSignupDetailsPage
  def initialize(browser)
    @browser = browser
  end

  def enter_code(code)
    @browser.text_field(:name => 'verify-code:codefield_container:code').set code
  end

  def enter_email(email)
    @browser.text_field(:name => 'emailSection:email').set email
  end

  def enter_password(password)
    @browser.text_fields(:type => 'password')[0].set password
  end

  def enter_password_confirm(password)
    @browser.text_fields(:type => 'password')[1].set password
  end

  def click_tnc_checkbox()
    @browser.input(:id => 'tnc-privacy-checkbox').click
  end

  def click_show_password_checkbox()
    @browser.input(:name => 'passwordBlock:isPlainPassword').click
  end

  def click_submit_button
    @browser.button(:type => 'submit').click
  end

  def click_cancel_button
    @browser.link(:class => 'spec_cancelButton').click
  end

  def get_error_messages
    @browser.spans(:class => 'feedbackPanelERROR')
  end

  def get_header()
    @browser.div(:id => 'details').h3
  end
end
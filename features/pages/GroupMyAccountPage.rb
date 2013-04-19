class GroupMyAccountPage
  def initialize(browser)
    @browser = browser
  end

  def enter_new_email(email)
    @browser.text_field(:id => 'email').set email
  end

  def click_submit_new_email_button
    @browser.a(:class => 'spec_changeButton').click
  end

  def enter_current_password(password)
    @browser.text_fields(:type=>'password')[0].set password
  end

  def enter_new_password(password)
    @browser.text_fields(:type=>'password')[1].set password
  end

  def enter_confirm_new_password(password)
    @browser.text_fields(:type=>'password')[2].set password
  end

  def click_submit_new_password_button
    #@browser.window(:url => the_url_of_your_page).use
    #Watir::Browser.attach(:title, ‘Vodafone’).input(:name => 'modal-dialog:dialog-content:changePasswordLink').click
    #@browser.input(:name => 'modal-dialog:dialog-content:changePasswordLink').click
    #@browser.text_fields(:type=>'password')[0].parent.parent.parent.parent.parent.submit
    @browser.input(:value=>'Save').click
  end

  def click_change_password
    @browser.div(:class => 'spec_changePass').a.click
  end

  def click_change_email
    @browser.button(:class => 'spec_updateButton').click
  end
  def click_back_button
    @browser.button(:class => 'spec_backButton').click
  end
  def click_ok_button_password_changed
    @browser.span(:text => 'OK').click
  end
end
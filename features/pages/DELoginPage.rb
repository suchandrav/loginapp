class DELoginPage
  def initialize(browser)
    @browser = browser
  end

  def enter_username(username)
    if /sso\.dev\.360\.com/.match(@browser.url)
      @browser.text_field(:id => 'IDToken1').set username
    else
      @browser.text_field(:id => 'name').set username
    end
  end

  def enter_password(password)
    if /sso\.dev\.360\.com/.match(@browser.url)
      @browser.text_field(:id => 'IDToken2').set password
    else
      @browser.text_field(:id => 'password').set password
    end
  end

  def click_login_button
    if /sso\.dev\.360\.com/.match(@browser.url)
      @browser.input(:name => 'Login.Submit').click
    else
      @browser.input(:type => 'submit').click
    end
  end

  def get_error_messages
    if /sso\.dev\.360\.com/.match(@browser.url)
      @browser.div(:class => 'AlrtErrTxt')
    else
      @browser.form(:id => 'vf360Login').p(:style => 'color:red;').element(:css => 'b')
    end
  end
end
class MessagePage
  def initialize(browser)
    @browser = browser
  end

  def get_message
    @browser.div(:id => 'details').p(:class => 'spec_panelHeaderText').text
  end

  def click_button(button_text)
    @browser.span(:text => button_text).click
  end
end
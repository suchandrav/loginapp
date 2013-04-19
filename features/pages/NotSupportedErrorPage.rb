class NotSupportedErrorPage
  def initialize(browser)
    @browser = browser
  end

  def get_error_message
    @browser.div(:id => 'details').p(:class => 'spec_headerText').text
  end
end
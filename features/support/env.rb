#!/usr/bin/env ruby
require 'watir-webdriver'
require 'open-uri'
require 'net/http'
require 'headless'

def get_browser(lang='en', incognito=true)
#  profile = Selenium::WebDriver::Chrome::Profile.new
#  profile['intl.accept_languages'] = lang
#  capabilities = WebDriver::Chrome::Capabilities.htmlunit(:proxy => '{"proxyType":"manual", "httpProxy":"localhost:9099", "sslProxy":"localhost:9099"}')
#  driver = Selenium::WebDriver.for :chrome, :profile => profile
  switches = ['--ignore-certificate-errors', '--proxy-server=localhost:9099', '--load-extension=./browser_profiles/chrome_removecookiesextension']
#  switches = ['--ignore-certificate-errors', '--incognito']
#  Watir::Browser.new driver, :switches => switches
  @headless = Headless.new
  @headless.start
  Watir::Browser.new :chrome, :switches => switches
end

def get_browser_firefox(lang='en')
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.assume_untrusted_certificate_issuer = false
  profile.proxy = Selenium::WebDriver::Proxy.new :http => 'localhost:9099', :ssl => 'localhost:9099'
  #profile.add_extension "../path/to/firebug.xpi"
  Watir::Browser.new :firefox, :profile => profile
end


browser = get_browser

Before do
  @browser = browser
end

at_exit do
  browser.close
  stop_proxy
  @headless.destroy
#commenting the purging of test data, which is not applicable to preprod testing
#  d = UserData.new
#  d.get_used_emails.each {|e| purge_delete_account_username e}
#  d.get_used_msisdns.each {|m| purge_delete_account_msisdn m}
  puts 'at Exit'
end


def take_screenshot(b, screenshot_file_name)
  unless /\.png$/i.match screenshot_file_name
    screenshot_file_name = screenshot_file_name+".png"
  end
  path = 'reports'
  Dir::mkdir(path) if not File.directory?(path)
  b.driver.save_screenshot(path+'/'+screenshot_file_name)
  screenshot_file_name
end

def screenshot_filename_from_scenario_name
  d = UserData.new
  @scenario_name.gsub(/current_msisdn/,d.get_current_msisdn).gsub(/current_email/,d.get_current_email).gsub(/\s+/, '_').gsub(/\W/, '').downcase+"_step_line_#{StepCounter.step_line}"
end

def embed_screenshot(screenshot_file_name)
  unless /\.png$/i.match screenshot_file_name
    screenshot_file_name = screenshot_file_name+".png"
  end
  path = 'reports'
  Dir::mkdir(path) if not File.directory?(path)
  FileUtils.chdir(path)
  embed screenshot_file_name, 'image/png', screenshot_file_name
  FileUtils.chdir('..')
end

def embed_trace_if_oops(b, screenshot_file_name)
  unless /\.log$/i.match screenshot_file_name
    screenshot_file_name = screenshot_file_name+".log"
  end
  trace_element = b.element(:css => '#footer-wrap + div')
  if trace_element.exists?
    trace_text = trace_element.html
    path = 'reports'
    Dir::mkdir(path) if not File.directory?(path)
    if /Caused by: com.vodafone.application.errors.ErrorCodeException:/.match trace_text
      probable_cause = /Caused by: com.vodafone.application.errors.ErrorCodeException:(.*)/.match(trace_text)[1]
      File.open('reports/oops_report.log', 'a') { |file| file.write(screenshot_file_name+" "+probable_cause+"\n") }
    elsif /java.net.SocketTimeoutException: Read timed out/.match trace_text
      probable_cause = /at com.vodafone.vfglogin.service.([A-Z].*)/.match(trace_text)[1]
      File.open('reports/oops_report.log', 'a') { |file| file.write(screenshot_file_name+" Read timed out "+probable_cause+"\n") }
    end
    File.open('reports/'+screenshot_file_name, 'w') { |file| file.write(trace_text) }
    FileUtils.chdir(path)
    embed screenshot_file_name, 'text/plain', "Source of error page for #{screenshot_file_name}"
    #embed "data:text/plain;"+URI::encode(trace_text), 'text/plain', "Source of error page for ERROR_#{screenshot_filename_from_scenario_name}"
    FileUtils.chdir('..')
  end
end


def embed_oops_report
  path = 'reports'
  Dir::mkdir(path) if not File.directory?(path)
  FileUtils.chdir(path)
  embed 'oops_report.log', 'text/plain', "Oops report"
  FileUtils.chdir('..')
end

def get_random_example_email
  time = Time.new
  microseconds = time.usec
  "test#{microseconds}@example.com"
end

def get_random_msisdn(msisdn)
  suffix = rand(100)
  "#{msisdn}#{suffix}"
end

def purge_delete_account_msisdn(msisdn)
  msisdn = msisdn.sub(%r{^\+},'')
  uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual?query=show&msisdn=#{msisdn}&msisdnVerified=true"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Get.new(uri.request_uri)
  req.basic_auth("VFTEST", "VFTEST")
  resp = http.request(req).body
  if /<individualId>(\d+)<\/individualId>/.match(resp)
    p 'Found msisdn='+msisdn+', deleting it'
    individual_id = /<individualId>(\d+)<\/individualId>/.match(resp)[1]
    delete_uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual/#{individual_id}?type=purge"
    delete_http = Net::HTTP.new delete_uri.host, delete_uri.port
    delete_req = Net::HTTP::Delete.new(delete_uri.request_uri)
    delete_req.basic_auth("VFTEST", "VFTEST")
    delete_req["vf-gig-ti-application-id"] = "AUTOTESTSAPPID"
    delete_req["vf-gig-ti-reference-id"] = "AUTOTESTSREFID"
    delete_req["vf-gig-ci-type"] = "AUTOTESTSCITYPE"
    delete_req["vf-gig-ti-correlation-id"] = "AUTOTESTSpurgedelete"
    delete_req["x-vf-audit-partner-id"] = "AUTOTESTSPARTNER"
    delete_req["vf-gig-ti-service-id"] = "AUTOTESTSSERVICEID"
    delete_req["vf-gig-ci-identifier"] = "AUTOTESTSIDENTIFIER"
    delete_req["vf-gig-ti-service-version"] = "1.0"
    delete_req["vf-gig-ti-timestamp"] = "2011-01-01T01:01:01Z"
    delete_req["vf-gig-ti-identity-id"] = "AUTOTESTSTRACKINGIDENTITYID"
    delete_resp = delete_http.request(delete_req)
    if delete_resp.code != '200'
#      if /SVC0001|SVC2740010/.match delete_resp.body
#        exec "kevins_script.sh #{individual_id}"
#      else
      path = 'reports'
      file_name = "ERROR_DELETE_"+screenshot_filename_from_scenario_name+".log"
      File.open(path+'/'+ file_name, 'w') { |file| file.write(delete_resp.body) }
      FileUtils.chdir(path)
      embed file_name, 'text/plain', file_name
      FileUtils.chdir('..')
#      end
    end
#    sleep 5
    p 'Deleted msisdn='+msisdn+' with 200'
    return delete_resp.code
  end
  p 'Didnt find msisdn='+msisdn+''
  '200'
end

def purge_delete_all_accounts_msisdn(msisdn)
  msisdn = msisdn.sub(%r{^\+},'')
  uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual?query=show&msisdn=#{msisdn}"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Get.new(uri.request_uri)
  req.basic_auth("VFTEST", "VFTEST")
  resp = http.request(req).body
  counter = 0
  return_resp_code = '200'
  while /<individualId>(\d+)<\/individualId>/.match(resp) and counter<=3
    individual_id = /<individualId>(\d+)<\/individualId>/.match(resp)[1]
    delete_uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual/#{individual_id}?type=purge"
    delete_http = Net::HTTP.new delete_uri.host, delete_uri.port
    delete_req = Net::HTTP::Delete.new(delete_uri.request_uri)
    delete_req.basic_auth("VFTEST", "VFTEST")
    delete_req["vf-gig-ti-application-id"] = "AUTOTESTSAPPID"
    delete_req["vf-gig-ti-reference-id"] = "AUTOTESTSREFID"
    delete_req["vf-gig-ci-type"] = "AUTOTESTSCITYPE"
    delete_req["vf-gig-ti-correlation-id"] = "AUTOTESTSpurgedelete"
    delete_req["x-vf-audit-partner-id"] = "AUTOTESTSPARTNER"
    delete_req["vf-gig-ti-service-id"] = "AUTOTESTSSERVICEID"
    delete_req["vf-gig-ci-identifier"] = "AUTOTESTSIDENTIFIER"
    delete_req["vf-gig-ti-service-version"] = "1.0"
    delete_req["vf-gig-ti-timestamp"] = "2011-01-01T01:01:01Z"
    delete_req["vf-gig-ti-identity-id"] = "AUTOTESTSTRACKINGIDENTITYID"
    delete_resp = delete_http.request(delete_req)
    if delete_resp.code != '200'
      path = 'reports'
      file_name = "ERROR_DELETE_"+screenshot_filename_from_scenario_name+".log"
      File.open(path+'/'+ file_name, 'w') { |file| file.write(delete_resp.body) }
      FileUtils.chdir(path)
      embed file_name, 'text/plain', file_name
      FileUtils.chdir('..')
    end
    resp = http.request(req).body
    counter +=1
    return_resp_code = delete_resp.code
  end
  return_resp_code
end


def purge_delete_account_username(username)
  uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual?query=show&username=#{username}"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Get.new(uri.request_uri)
  req.basic_auth("VFTEST", "VFTEST")
  resp = http.request(req).body
  if /<individualId>(\d+)<\/individualId>/.match(resp)
    p 'Found username='+username+', deleting it'
    individual_id = /<individualId>(\d+)<\/individualId>/.match(resp)[1]
    delete_uri = URI.parse "http://gig-dit.sp.vodafone.com:30830/lifecycle/individual/#{individual_id}?type=purge"
    delete_http = Net::HTTP.new delete_uri.host, delete_uri.port
    delete_req = Net::HTTP::Delete.new(delete_uri.request_uri)
    delete_req.basic_auth("VFTEST", "VFTEST")
    delete_req["vf-gig-ti-application-id"] = "AUTOTESTSAPPID"
    delete_req["vf-gig-ti-reference-id"] = "AUTOTESTSREFID"
    delete_req["vf-gig-ci-type"] = "AUTOTESTSCITYPE"
    delete_req["vf-gig-ci-identifier"] = "AUTOTESTSIDENTIFIER"
    delete_req["vf-gig-ti-correlation-id"] = "AUTOTESTSpurgedelete"
    delete_req["x-vf-audit-partner-id"] = "AUTOTESTSPARTNER"
    delete_req["vf-gig-ti-service-id"] = "AUTOTESTSSERVICEID"
    delete_req["vf-gig-ti-service-version"] = "1.0"
    delete_req["vf-gig-ti-timestamp"] = "2011-01-01T01:01:01Z"
    delete_req["vf-gig-ti-identity-id"] = "AUTOTESTSTRACKINGIDENTITYID"
    delete_resp = delete_http.request(delete_req)
    if delete_resp.code != '200'
      path = 'reports'
      file_name = "ERROR_DELETE_"+screenshot_filename_from_scenario_name+".log"
      File.open(path+'/'+ file_name, 'w') { |file| file.write(delete_resp.body) }
      FileUtils.chdir(path)
      embed file_name, 'text/plain', file_name
      FileUtils.chdir('..')
    end
#    sleep 5
    p 'Deleted username='+username+' with 200'
    return delete_resp.code
  end
  p 'Didnt find username='+username+''
  '200'
end

def create_proxy_with_browsermob(proxy_port='9099', browsermob_port='9090')
  uri = URI.parse "http://localhost:#{browsermob_port}/proxy"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Post.new(uri.request_uri)
  req.set_form_data({"port" => proxy_port})
  resp = http.request(req)
  if resp.code != '200'
    path = 'reports'
    file_name = "ERROR_STARTING_PROXY_"+screenshot_filename_from_scenario_name+".log"
    File.open(path+'/'+ file_name, 'w') { |file| file.write(resp.body) }
    FileUtils.chdir(path)
    embed file_name, 'text/plain', file_name
    FileUtils.chdir('..')
    return resp.code
  end
  #The main point of the proxy.  It adds a header to hit DIT2 instead of DIT1
  uri = URI.parse "http://localhost:#{browsermob_port}/proxy/#{proxy_port}/headers"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Post.new(uri.request_uri)
  req.body = '{"x-vf-dit2hint": "TRUE"}'
  req["Content-type"] = "application/json"
  resp = http.request(req)
  if resp.code != '200'
    path = 'reports'
    file_name = "ERROR_ADDING_HEADERS_PROXY_"+screenshot_filename_from_scenario_name+".log"
    File.open(path+'/'+ file_name, 'w') { |file| file.write(resp.body) }
    FileUtils.chdir(path)
    embed file_name, 'text/plain', file_name
    FileUtils.chdir('..')
    return resp.code
  end
end

def start_proxy(proxy_port='9099', browsermob_port='9090')
  begin
    create_proxy_with_browsermob(proxy_port, browsermob_port)
  rescue
    #Because I don't know how to kill it, it's most likely already running.
    #So I only start it when it fails
    system "sh proxy_server/bin/browsermob-proxy -port #{browsermob_port} &"
    sleep 10
    create_proxy_with_browsermob(proxy_port, browsermob_port)
  end
end


def stop_proxy(proxy_port='9099', browsermob_port='9090')
  uri = URI.parse "http://localhost:#{browsermob_port}/proxy/#{proxy_port}"
  http = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Delete.new(uri.request_uri)
  resp = http.request(req)
  if resp.code != '200'
    path = 'reports'
    file_name = "ERROR_STOPPING_PROXY_"+screenshot_filename_from_scenario_name+".log"
    File.open(path+'/'+ file_name, 'w') { |file| file.write(resp.body) }
    FileUtils.chdir(path)
    embed file_name, 'text/plain', file_name
    FileUtils.chdir('..')
  end
  #This doesn't work, I don't know how to kill the proxy's main process.
  system "ps -ef | grep browsermob-proxy | perl -ne 'print if /java/;' | perl -ane 'print @F[1];' | xargs kill -9"
end


def clear_cookies_with_extension
  #The proxy is very smart and fiddles with the jsessionid cookies.  It remembers them or something.
  #By restarting it, we clear that weird cache of cookies.
  stop_proxy
  start_proxy
  @browser.cookies.clear
  #I just call something and match the parameter, the actual domain is irrelevant, just leave this
  @browser.goto 'https://vfglogin.vodafone.com/version'
  @browser.goto 'https://vfglogin.vodafone.com/version?deleteallcookiesextensionhack=true'
end
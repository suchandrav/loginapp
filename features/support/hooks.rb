File.open('reports/oops_report.log', 'w') { |file| file.write("Oops\n") }
@scenario_name = "before_first_test"
start_proxy

#'Before' hooks run in the order they are defined
Before do |scenario|
  if scenario.respond_to? 'feature'
    @scenario_name = scenario.name
  else
    @scenario_name = scenario.scenario_outline.name+"_"+scenario.name
  end
  StepCounter.step_index = 0
  if scenario.respond_to? 'raw_steps' then
    StepCounter.step_line = scenario.raw_steps[StepCounter.step_index].line
  else
    StepCounter.step_line = scenario.scenario_outline.raw_steps[StepCounter.step_index].line
  end
end


Before('~@dont_delete_cookies_before') do
  clear_cookies_with_extension
end

#'After' hooks run in REVERSE order they are defined in
After('@do_or_die') do |scenario|
  if scenario.failed?
    Cucumber.wants_to_quit = true
  end
end

After do |scenario|
  if scenario.failed?
    embed_screenshot (take_screenshot @browser, "ERROR_"+screenshot_filename_from_scenario_name)
    embed_trace_if_oops @browser, "ERROR_"+screenshot_filename_from_scenario_name
  else
    #embed_screenshot (take_screenshot screenshot_filename_from_scenario_name)
  end
end

AfterStep('@debug_screenshot_each_step') do |scenario|
  embed_screenshot take_screenshot(@browser, "STEP_"+screenshot_filename_from_scenario_name)
end

AfterStep do |scenario|
  #Handle multiline steps
  StepCounter.step_index = StepCounter.step_index + 1
  if scenario.respond_to? 'raw_steps' then
    StepCounter.step_line = scenario.raw_steps[StepCounter.step_index].line unless scenario.raw_steps[StepCounter.step_index].nil?
  else
    StepCounter.step_line = scenario.scenario_outline.raw_steps[StepCounter.step_index].line unless scenario.scenario_outline.raw_steps[StepCounter.step_index].nil?
  end
end

StepCounter = Class.new
class << StepCounter
  @step_index = 0
  @step_line = 0
  attr_accessor :step_index, :step_line
end




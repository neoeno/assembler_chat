When(/^I post "([^"]*)" to the list$/) do |message|
  @chat_page.send_message(message)
end

Then(/^I see register "([^"]*)" is "([^"]*)"$/) do |register_name, register_value|
  expect(@chat_page.machine_state.register(register_name)).to have_text register_value
end

When(/^Geoff posts "([^"]*)" to the list$/) do |message|
  Capybara.using_session(GEOFF_SESSION) do
    @chat_page = ChatIndexPage.new
    @chat_page.load
    @chat_page.send_message message
  end
end

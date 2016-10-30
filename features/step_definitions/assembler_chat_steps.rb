When(/^I post "([^"]*)" to the list$/) do |message|
  @chat_page.send_message(message)
end

Then(/^I see register "([^"]*)" is (\d+)$/) do |register_name, number|
  expect(@chat_page.machine_state.register(register_name)).to have_text number
end

When(/^Geoff posts "([^"]*)" to the list$/) do |message|
  Capybara.using_session(GEOFF_SESSION) do
    @chat_page = ChatIndexPage.new
    @chat_page.load
    @chat_page.send_message message
  end
end

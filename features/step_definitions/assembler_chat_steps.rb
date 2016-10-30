When(/^I post "([^"]*)" to the list$/) do |message|
  @chat_page.send_message(message)
end

Then(/^I see register AX change to (\d+)$/) do |number|
  expect(@chat_page.machine_state.register_ax).to have_text number
end

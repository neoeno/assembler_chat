When(/^I post "([^"]*)" to the list$/) do |message|
  @chat_page.send_message(message)
end

Then(/^I see register AX change to (\d+)$/) do |number|
  expect(@chat_page.machine_state).to have_register_ax(content: number)
end

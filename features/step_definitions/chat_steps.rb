Given(/^an empty list$/) do
  visit root_path
end

When(/^I add a message to the list$/) do
  within("#chat_message_form") do
    fill_in "Message", with: "A message"
    click_button "Send"
  end
end

Then(/^I see my message at the bottom of the list$/) do
  expect(find("#room")).to have_content("A message")
end

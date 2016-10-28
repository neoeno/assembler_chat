require_relative '../support/pages/chat_index_page'

Given(/^an empty list$/) do
  @chat_page = ChatIndexPage.new
  @chat_page.load
end

When(/^I add a message to the list$/) do
  @chat_page.message_body_field.set "A message"
  @chat_page.send_button.click
end

When(/^Geoff adds a message to the list$/) do
  Capybara.using_session("geoff") do
    geoff_chat_page = ChatIndexPage.new
    geoff_chat_page.load
    geoff_chat_page.message_body_field.set "hello i'm geoff"
    geoff_chat_page.send_button.click
  end
end

Then(/^I see my message in the list$/) do
  expect(@chat_page.messages).to eq ["A message"]
end

Then(/^I see Geoff's message in the list$/) do
  expect(@chat_page.messages).to eq ["hello i'm geoff"]
end

Then(/^my message field is reset$/) do
  expect(@chat_page.message_body_field.value).to eq ""
end

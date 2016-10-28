require_relative '../support/pages/chat_index_page'

MY_MESSAGE = "A message"
GEOFFS_MESSAGE = "hello i'm geoff"

Given(/^an empty list$/) do
  @chat_page = ChatIndexPage.new
  @chat_page.load
end

When(/^I add a message to the list$/) do
  @chat_page.message_body_field.set MY_MESSAGE
  @chat_page.send_button.click
end

When(/^Geoff adds a message to the list$/) do
  Capybara.using_session("geoff") do
    geoff_chat_page = ChatIndexPage.new
    geoff_chat_page.load
    geoff_chat_page.message_body_field.set GEOFFS_MESSAGE
    geoff_chat_page.send_button.click
  end
end

Then(/^I see my message in the list$/) do
  expect(@chat_page.messages).to eq [MY_MESSAGE]
end

Then(/^I see Geoff's message in the list$/) do
  expect(@chat_page.messages).to eq [GEOFFS_MESSAGE]
end

Then(/^I see Geoff's message first, then mine$/) do
  expect(@chat_page.messages).to eq [GEOFFS_MESSAGE, MY_MESSAGE]
end

Then(/^my message field is reset$/) do
  expect(@chat_page.message_body_field.value).to eq ""
end

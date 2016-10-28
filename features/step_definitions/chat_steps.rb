require_relative '../support/pages/chat_index_page'

MY_MESSAGE = "A message"
MY_CUSTOM_USERNAME = "Kay"
GEOFFS_MESSAGE = "hello i'm geoff"
GEOFF_SESSION = "geoff_session"

Given(/^an empty list$/) do
  @chat_page = ChatIndexPage.new
  @chat_page.load
end

When(/^I add a message to the list$/) do
  @chat_page.message_body_field.set MY_MESSAGE
  @chat_page.send_button.click
end

When(/^I set my username to Kay$/) do
  @chat_page.username_field.set MY_CUSTOM_USERNAME
end

When(/^Geoff adds a message to the list$/) do
  Capybara.using_session(GEOFF_SESSION) do
    @chat_page = ChatIndexPage.new
    @chat_page.load
    @chat_page.message_body_field.set GEOFFS_MESSAGE
    @chat_page.send_button.click
  end
end

Then(/^I see my message in the list$/) do
  expect(@chat_page.messages).to eq [{
    username: @chat_page.username,
    body: MY_MESSAGE
  }]
end

Then(/^I see my username by my message in the list$/) do
  expect(@chat_page.messages).to eq [{
    username: @chat_page.username,
    body: MY_MESSAGE
  }]
end

Then(/^I see Geoff's message in the list$/) do
  geoff_username = Capybara.using_session(GEOFF_SESSION) { @chat_page.username }
  expect(@chat_page.messages).to eq [{
    username: geoff_username,
    body: GEOFFS_MESSAGE
  }]
end

Then(/^I see Geoff's message first, then mine$/) do
  geoff_username = Capybara.using_session(GEOFF_SESSION) { @chat_page.username }
  expect(@chat_page.messages).to eq [
    {
      username: geoff_username,
      body: GEOFFS_MESSAGE
    },
    {
      username: @chat_page.username,
      body: MY_MESSAGE
    }
  ]
end

Then(/^my message field is reset$/) do
  expect(@chat_page.message_body_field.value).to eq ""
end

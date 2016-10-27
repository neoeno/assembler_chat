Given(/^an empty list$/) do
  visit root_path
end

When(/^I add a message to the list$/) do
  within("#chat_message_form") do
    fill_in "Message", with: "A message"
    click_button "Send"
  end
end

When(/^Geoff adds a message to the list$/) do
  Capybara.using_session("geoff") do
    visit root_path
    fill_in "Message", with: "A message from Geoff"
    click_button "Send"
  end
end

Then(/^I see my message at the bottom of the list$/) do
  expect(find("#message_list")).to have_content("A message")
end

Then(/^I see Geoff's message at the bottom of the list$/) do
  expect(find("#message_list")).to have_content("A message from Geoff")
end

Then(/^my message field is reset$/) do
  expect(page).to have_field('Message', with: '')
end

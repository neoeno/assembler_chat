require_relative "./chat_message_section"

class ChatIndexPage < SitePrism::Page
  set_url "/"

  element :username_field, "#chat_message_form_username"
  element :message_body_field, "#chat_message_form_body"
  element :send_button, "#chat_message_form_submit"

  sections :messages, ChatMessageSection, ".test-message"

  def username
    username_field.value
  end

  def send_message(message)
    message_body_field.set message
    send_button.click
  end

  def has_exactly_these_messages?(expected_messages)
    # We wait here because we're using a complex matcher that won't trigger
    # Capybara's smart waiting behaviour — so we do it ourselves
    wait_for_messages nil, :count => expected_messages.length
    message_list == expected_messages
  end

  private def message_list
    messages.map(&:to_h)
  end
end

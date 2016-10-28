require_relative "./chat_message_section"

class ChatIndexPage < SitePrism::Page
  set_url "/"

  element :username_field, "#chat_message_form_username"
  element :message_body_field, "#chat_message_form_body"
  element :send_button, "#chat_message_form_submit"
  element :message_list, "#message_list"

  sections :messages, ChatMessageSection, ".test-message"

  def message_list
    messages.map(&:to_h)
  end

  def username
    username_field.value
  end
end

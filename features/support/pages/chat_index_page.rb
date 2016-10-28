class ChatIndexPage < SitePrism::Page
  set_url "/"

  element :message_body_field, "#chat_message_form_body"
  element :send_button, "#chat_message_form_submit"
  element :message_list, "#message_list"
end

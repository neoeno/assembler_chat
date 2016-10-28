class ChatIndexPage < SitePrism::Page
  set_url "/"

  element :username_field, "#chat_message_form_username"
  element :message_body_field, "#chat_message_form_body"
  element :send_button, "#chat_message_form_submit"
  element :message_list, "#message_list"

  elements :message_elements, "#message_list li"

  def messages
    message_elements.map do |element|
      {
        username: element.find(".test-message-username").text,
        body: element.find(".test-message-body").text
      }
    end
  end

  def username
    username_field.value
  end
end

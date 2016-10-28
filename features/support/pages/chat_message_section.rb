class ChatMessageSection < SitePrism::Section
  element :username, ".test-message-username"
  element :body, ".test-message-body"

  def to_h
    {
      username: username.text,
      body: body.text
    }
  end
end

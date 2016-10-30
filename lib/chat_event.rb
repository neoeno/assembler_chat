class ChatEvent
  # Don't use this — add a new class method if you want to create a new
  # event and put all the logic in there
  def initialize(type, payload)
    @type = type
    @payload = payload
  end

  def self.new_message(message)
    self.new("newMessage", SimpleMessagePresenter.new(message))
  end

  def self.sync_messages(messages)
    simple_messages = messages.map { |message| SimpleMessagePresenter.new(message) }
    self.new("syncMessages", simple_messages)
  end

  # We let the default as_json method serialize our instance variables

  class SimpleMessagePresenter
    def initialize(message)
      @message = message
    end

    def as_json(options)
      @message.as_json({only: [:body, :username]}.merge(options))
    end
  end
end

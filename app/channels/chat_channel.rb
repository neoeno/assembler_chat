# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "the_room"
    transmit({eventType: "syncMessages", messages: Message.order(created_at: :asc)})
  end

  def receive(data)
    # Channels have some strange initialization / forking? stuff going on which
    # hampers our attempt to make this an instance variable, so we'll initialize
    # it each time for now
    message_store = MessageStore.new
    message = message_store.receive(data)
    ActionCable.server.broadcast("the_room", {eventType: "newMessage", message: message})
  end
end

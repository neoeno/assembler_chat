# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    @message_store = MessageStore.new
    stream_from "the_room"
    transmit({eventType: "syncMessages", messages: Message.order(created_at: :asc)})
  end

  def receive(data)
    message = @message_store.receive(data)
    ActionCable.server.broadcast("the_room", {eventType: "newMessage", message: message})
  end
end

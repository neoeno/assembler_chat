# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "the_room"
  end

  def receive(data)
    ActionCable.server.broadcast("the_room", data)
  end
end

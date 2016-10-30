# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    @message_assembler = Interpreters::MessageInterpreter.new(Interpreters::TolerantAssemblerInterpreter.new)
    @message_store = MessageStore.new
    stream_from "the_room"
    transmit_message_sync_event!
  end

  def receive(data)
    message = @message_store.post_message(data)
    ActionCable.server.broadcast("the_room", ChatEvent.new_message(message))
    ActionCable.server.broadcast("the_room", ChatEvent.state_change(message.state))
  end

  private def transmit_message_sync_event!
    transmit(
      ChatEvent.sync_messages(@message_store.latest_messages)
    )
  end
end

# Responsible for inserting, updating, otherwise interacting with the message
# database (via the models)  chiefly (though not exclusively) on the instruction
# of channels. The ActionCable testing story is not complete at this point, so
# rather than put all of the logic in there and render it untestable or liable
# to fail in future, we'll put it all here

class MessageStore
  def initialize
    @message_interpreter = Interpreters::MessageInterpreter.new(
      Interpreters::TolerantAssemblerInterpreter.new
    )
  end

  def post_message(json_message)
    attributes = safe_params(json_message)
    attributes = attributes.merge({state: interpret(attributes[:body])})
    Message.create(attributes)
  end

  def latest_messages
    Message.order(created_at: :asc).last(100)
  end

  def latest_state
    latest_message = latest_messages.last
    prior_state = latest_message.try(:state) || @message_interpreter.initial_state
  end

  private def safe_params(raw_params)
    params = ActionController::Parameters.new(raw_params)
    params.permit(:username, :body)
  end

  private def interpret(message_body)
    @message_interpreter.interpret(latest_state, message_body)
  end
end

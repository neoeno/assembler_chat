# Responsible for inserting, updating, otherwise interacting with the message
# database (via the models)  chiefly (though not exclusively) on the instruction
# of channels. The ActionCable testing story is not complete at this point, so
# rather than put all of the logic in there and render it untestable or liable
# to fail in future, we'll put it all here

class MessageStore
  def post_message(json_message)
    Message.create(safe_params(json_message))
  end

  def latest_messages
    Message.order(created_at: :asc).last(100)
  end

  private def safe_params(raw_params)
    params = ActionController::Parameters.new(raw_params)
    params.permit(:username, :body)
  end
end

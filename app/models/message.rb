class Message < ApplicationRecord
  def state=(state)
    self.state_json = state.to_json
  end

  def state
    JSON.parse(state_json)
  end
end

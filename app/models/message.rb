class Message < ApplicationRecord
  # More of a presentation concern really
  def to_json
    slice(:body, :username).to_json
  end
end

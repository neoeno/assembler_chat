require 'rails_helper'

RSpec.describe Message, type: :model do
  REASONABLE_ATTRIBUTES = {username: "hello", body: "world"}.freeze

  describe "#new" do
    it "constructs successfully with reasonable attributes" do
      message = Message.new(REASONABLE_ATTRIBUTES)
      expect(message.attributes).to include REASONABLE_ATTRIBUTES.stringify_keys
    end
  end
end

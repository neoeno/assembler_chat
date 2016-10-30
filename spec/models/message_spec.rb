require 'rails_helper'

RSpec.describe Message, type: :model do
  REASONABLE_ATTRIBUTES = {username: "hello", body: "world", state_json: "{\"a\":1}"}.freeze

  describe "#new" do
    it "constructs successfully with reasonable attributes" do
      message = Message.new(REASONABLE_ATTRIBUTES)
      expect(message.attributes).to include REASONABLE_ATTRIBUTES.stringify_keys
    end
  end

  describe "#state" do
    it "returns the state_json as a hash" do
      message = Message.new(REASONABLE_ATTRIBUTES)
      expect(message.state).to eq({"a" => 1})
    end
  end

  describe "#state=" do
    it "sets the state_json with JSON representation of the argument" do
      message = Message.new
      message.state = {b: 2}
      expect(message.state_json).to eq "{\"b\":2}"
    end
  end
end

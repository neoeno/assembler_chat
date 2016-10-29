require 'rails_helper'

RSpec.describe MessageStore do
  describe "#receive" do
    let(:message_json) { {"username" => "my_username", "body" => "hello I am a chat"} }

    it "returns a representative message object" do
      message = subject.receive(message_json)
      expect(message.attributes).to include message_json
    end

    it "does not apply extraneous attributes" do
      extraneous_attributes = {"id" => 5}
      message = subject.receive(message_json.merge(extraneous_attributes))
      expect(message.attributes).to_not include extraneous_attributes
    end

    it "persists the message object to the database" do
      allegedly_saved_message = subject.receive(message_json)

      message = Message.find(allegedly_saved_message.id)
      expect(message.attributes).to include message_json
    end
  end
end

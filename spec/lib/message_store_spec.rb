require 'rails_helper'

RSpec.describe MessageStore do
  EXAMPLE_MESSAGE_JSON = {"username" => "my_username", "body" => "hello I am a chat"}.freeze

  describe "#receive" do
    it "returns a representative message object" do
      message = subject.receive(EXAMPLE_MESSAGE_JSON)
      expect(message.attributes).to include EXAMPLE_MESSAGE_JSON
    end

    it "does not apply extraneous attributes" do
      extraneous_attributes = {"id" => 5}
      message = subject.receive(EXAMPLE_MESSAGE_JSON.merge(extraneous_attributes))
      expect(message.attributes).to_not include extraneous_attributes
    end

    it "persists the message object to the database" do
      allegedly_saved_message = subject.receive(EXAMPLE_MESSAGE_JSON)

      message = Message.find(allegedly_saved_message.id)
      expect(message.attributes).to include EXAMPLE_MESSAGE_JSON
    end
  end

  describe "#latest_messages" do
    context "with empty store" do
      it "returns an empty list" do
        expect(subject.latest_messages).to eq []
      end
    end

    context "with some messages in the store" do
      it "returns the messages in ascending order by `created_at`" do
        message_newer = Message.create(EXAMPLE_MESSAGE_JSON)
        message_older = Message.create(EXAMPLE_MESSAGE_JSON.merge(created_at: 1.year.ago))
        expect(subject.latest_messages).to eq [message_older, message_newer]
      end

      it "returns a max of 100 messages" do
        101.times do
          Message.create(EXAMPLE_MESSAGE_JSON)
        end
        expect(subject.latest_messages.length).to eq 100
      end

      it "returns the latest 100 messages" do
        100.times do
          Message.create(EXAMPLE_MESSAGE_JSON)
        end
        old_message = Message.create(EXAMPLE_MESSAGE_JSON.merge(created_at: 1.year.ago))
        expect(subject.latest_messages).to_not include old_message
      end
    end
  end
end

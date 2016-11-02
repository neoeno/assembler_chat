require 'rails_helper'

RSpec.describe MessageStore do
  EXAMPLE_MESSAGE_JSON = {"username" => "my_username", "body" => "hello I am a chat"}.freeze
  EXECUTABLE_MESSAGE_JSON = {"username" => "my_username", "body" => "MOV ax, 5d"}.freeze
  EXECUTABLE_MESSAGE_JSON_2 = {"username" => "my_username", "body" => "MOV bx, 10d"}.freeze

  describe "#post_message" do
    it "returns a representative message object" do
      message = subject.post_message(EXAMPLE_MESSAGE_JSON)
      expect(message.attributes).to include EXAMPLE_MESSAGE_JSON
    end

    it "does not apply extraneous attributes" do
      extraneous_attributes = {"id" => 5}
      message = subject.post_message(EXAMPLE_MESSAGE_JSON.merge(extraneous_attributes))
      expect(message.attributes).to_not include extraneous_attributes
    end

    it "persists the message object to the database" do
      allegedly_saved_message = subject.post_message(EXAMPLE_MESSAGE_JSON)

      message = Message.find(allegedly_saved_message.id)
      expect(message.attributes).to include EXAMPLE_MESSAGE_JSON
    end

    context "with an empty message store" do
      context "and a non-executable message" do
        let(:message) { subject.post_message(EXAMPLE_MESSAGE_JSON) }

        it "sets the message state to the initial state" do
          expect(message.state).to eq({
            "ax" => i_to_byte(0),
            "bx" => i_to_byte(0),
            "cx" => i_to_byte(0),
            "dx" => i_to_byte(0)
          })
        end
      end

      context "and an executable message" do
        let(:message) { subject.post_message(EXECUTABLE_MESSAGE_JSON) }

        it "executes on the initial state" do
          expect(message.state).to eq({
            "ax" => i_to_byte(5),
            "bx" => i_to_byte(0),
            "cx" => i_to_byte(0),
            "dx" => i_to_byte(0)
          })
        end
      end
    end

    context "with a message store containing state already" do
      before { subject.post_message(EXECUTABLE_MESSAGE_JSON_2) }

      context "and a non-executable message" do
        let(:message) { subject.post_message(EXAMPLE_MESSAGE_JSON) }

        it "sets the messate state to the initial state" do
          expect(message.state).to eq({
            "ax" => i_to_byte(0),
            "bx" => i_to_byte(10),
            "cx" => i_to_byte(0),
            "dx" => i_to_byte(0)
          })
        end
      end

      context "and an executable message" do
        let(:message) { subject.post_message(EXECUTABLE_MESSAGE_JSON) }

        it "executes on the initial state" do
          expect(message.state).to eq({
            "ax" => i_to_byte(5),
            "bx" => i_to_byte(10),
            "cx" => i_to_byte(0),
            "dx" => i_to_byte(0)
          })
        end
      end
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

  describe "#latest_state" do
    context "with empty store" do
      it "returns the initial state" do
        expect(subject.latest_state).to eq({
          "ax" => Assembler::Byte.from_i(0),
          "bx" => Assembler::Byte.from_i(0),
          "cx" => Assembler::Byte.from_i(0),
          "dx" => Assembler::Byte.from_i(0)
        })
      end
    end

    context "with some messages in the store" do
      it "returns the state of the latest message" do
        message_newer = Message.create(username: "who", body: "cares", state: {a: 5})
        message_older = Message.create(username: "who", body: "cares", state: {a: 9}, created_at: 1.year.ago)

        expect(subject.latest_state).to eq({
          "a" => 5
        })
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ChatEvent do
  describe ".new_message" do
    let(:message) { Message.new(username: "hello", body: "world") }
    subject { described_class.new_message(message) }

    describe "#to_json" do
      let(:json_result) { JSON.parse(subject.to_json) }

      it "returns a hash with newMessage as the event type" do
        expect(json_result["type"]).to eq "newMessage"
      end

      it "returns a hash with a pared down message as the payload" do
        expect(json_result["payload"]).to eq({
          "username" => message.username,
          "body" => message.body
        })
      end
    end
  end

  describe ".sync_messages" do
    let(:messages) { [
      Message.new(username: "hello", body: "world"),
      Message.new(username: "cat", body: "dog")
    ] }
    subject { described_class.sync_messages(messages) }

    describe "#as_json" do
      let(:json_result) { JSON.parse(subject.to_json) }

      it "returns a hash with syncMessages as the event type" do
        expect(json_result["type"]).to eq "syncMessages"
      end

      it "returns a hash with a list of pared down messages as the payload" do
        expect(json_result["payload"]).to eq([
          {
            "username" => messages[0].username,
            "body" => messages[0].body
          },
          {
            "username" => messages[1].username,
            "body" => messages[1].body
          }
        ])
      end
    end
  end
end

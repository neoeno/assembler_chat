require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:reasonable_attributes) { {username: "hello", body: "world"} }

  describe("#new") do
    it "constructs successfully with reasonable attributes" do
      message = Message.new(reasonable_attributes)
      expect(message.attributes).to include reasonable_attributes.stringify_keys
    end
  end

  describe("#to_json") do
    it "returns a JSON string value with reasonable attributes" do
      message = Message.new(reasonable_attributes)
      json_hash = JSON.parse(message.to_json)
      expect(json_hash).to include reasonable_attributes.stringify_keys
    end

    it "does not include extraneous attributes in the JSON form" do
      message = Message.new(reasonable_attributes)
      json_hash = JSON.parse(message.to_json)
      expect(json_hash).to_not have_key(:id)
    end
  end
end

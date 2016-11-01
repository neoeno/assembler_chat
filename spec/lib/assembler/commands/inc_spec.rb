require 'rails_helper'

RSpec.describe Assembler::Commands::Inc do
  describe "#execute" do
    it "modifies the given state" do
      initial_state = Assembler::State.new(bx: 2)
      command = described_class.new("bx")
      expect(command.execute(initial_state).to_h).to eq({
        "ax" => 0,
        "bx" => 3,
        "cx" => 0,
        "dx" => 0
      })
    end
  end
end

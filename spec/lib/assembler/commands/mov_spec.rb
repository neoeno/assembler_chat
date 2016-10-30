require 'rails_helper'

RSpec.describe Assembler::Commands::Mov do
  describe "#execute" do
    it "modifies the given state" do
      initial_state = {ax: 0, bx: 0, cx: 0, dx: 0}
      command = described_class.new("ax", 5)
      expect(command.execute(initial_state)).to eq({
        ax: 5,
        bx: 0,
        cx: 0,
        dx: 0
      })
    end
  end
end

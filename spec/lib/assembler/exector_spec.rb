require 'rails_helper'

RSpec.describe Assembler::Executor do
  describe ".execute" do
    it "executes mov statements" do
      statement = ["mov", "ax", 1]
      initial_state = {ax: 0, bx: 0, cx: 0, dx: 0}
      state = described_class.execute(initial_state, statement)
      expect(state).to eq({
        ax: 1,
        bx: 0,
        cx: 0,
        dx: 0
      })
    end
  end
end

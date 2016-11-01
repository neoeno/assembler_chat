require 'rails_helper'

RSpec.describe Assembler::Executor do
  describe ".execute" do
    it "executes mov statements" do
      statement = ["mov", "ax", [:constant, 1]]
      initial_state = Assembler::State.new
      state = described_class.execute(initial_state, statement)
      expect(state.to_h).to eq({
        "ax" => 1,
        "bx" => 0,
        "cx" => 0,
        "dx" => 0
      })
    end
  end
end

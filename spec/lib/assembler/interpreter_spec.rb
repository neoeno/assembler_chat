require 'rails_helper'

RSpec.describe Assembler::Interpreter do
  describe "#initial_state" do
    it "returns a hash of registers" do
      expect(subject.initial_state).to eq({
        ax: 0,
        bx: 0,
        cx: 0,
        dx: 0
      })
    end
  end

  describe "#interpret" do
    it "interprets mov statements" do
      state = subject.initial_state
      statement = "mov AX, 10d"
      expect(subject.interpret(state, statement)).to eq({
        ax: 10,
        bx: 0,
        cx: 0,
        dx: 0
      })
    end
  end
end
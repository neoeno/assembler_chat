require 'rails_helper'

RSpec.describe Interpreters::TolerantAssemblerInterpreter do
  describe "#initial_state" do
    it "returns a hash of registers" do
      expect(subject.initial_state).to eq({
        "ax" => Assembler::Word.from_i(0),
        "bx" => Assembler::Word.from_i(0),
        "cx" => Assembler::Word.from_i(0),
        "dx" => Assembler::Word.from_i(0)
      })
    end
  end

  describe "#interpret" do
    it "interprets mov statements" do
      state = subject.initial_state
      statement = "mov AX, 10d"
      expect(subject.interpret(state, statement)).to eq({
        "ax" => Assembler::Word.from_i(10),
        "bx" => Assembler::Word.from_i(0),
        "cx" => Assembler::Word.from_i(0),
        "dx" => Assembler::Word.from_i(0)
      })
    end

    it "returns initial state on erroneous input" do
      state = subject.initial_state
      statement = "fb788qghf74qh98qh"
      expect(subject.interpret(state, statement)).to eq({
        "ax" => Assembler::Word.from_i(0),
        "bx" => Assembler::Word.from_i(0),
        "cx" => Assembler::Word.from_i(0),
        "dx" => Assembler::Word.from_i(0)
      })
    end

  end
end

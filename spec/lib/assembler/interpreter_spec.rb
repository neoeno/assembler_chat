require 'rails_helper'

RSpec.describe Assembler::Interpreter do
  describe "#initial_state" do
    it "returns a hash of registers" do
      expect(subject.initial_state).to eq({
        "ax" => 0,
        "bx" => 0,
        "cx" => 0,
        "dx" => 0
      })
    end
  end

  describe "#interpret" do
    it "interprets mov statements" do
      state = subject.initial_state
      statement = "mov AX, 10d"
      expect(subject.interpret(state, statement)).to eq({
        "ax" => 10,
        "bx" => 0,
        "cx" => 0,
        "dx" => 0
      })
    end

    it "throws InterpreterException on lexing errors" do
      state = subject.initial_state
      statement = "fb788qghf74qh98qh"
      expect { subject.interpret(state, statement) }.to raise_error(Assembler::InterpreterException)
    end

    it "throws InterpreterException on parsing errors" do
      state = subject.initial_state
      statement = "mov AX 10d"
      expect { subject.interpret(state, statement) }.to raise_error(Assembler::InterpreterException)
    end
  end
end

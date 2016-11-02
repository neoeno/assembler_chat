require 'rails_helper'

RSpec.describe Assembler::Interpreter do
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
end

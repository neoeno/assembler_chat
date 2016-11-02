require 'rails_helper'

RSpec.describe Assembler::Interpreter do
  describe "#initial_state" do
    it "returns a hash of registers" do
      expect(subject.initial_state).to eq({
        "ax" => Assembler::Byte.from_i(0),
        "bx" => Assembler::Byte.from_i(0),
        "cx" => Assembler::Byte.from_i(0),
        "dx" => Assembler::Byte.from_i(0)
      })
    end
  end
end

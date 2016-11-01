require 'rails_helper'
require 'support/assembler_state_utils'

RSpec.describe Assembler::Commands::Sub do
  describe "#execute" do
    context "with a constant" do
      it "subtracts the constant from the register" do
        initial_state = Assembler::State.new(ax: 5)
        command = described_class.new("ax", [:constant, 2])
        expect(command.execute(initial_state)).to eq_state(ax: 3, bx: 0, cx: 0, dx: 0)
      end
    end

    context "with a second register" do
      it "subtracts the value of the second register from the first" do
        initial_state = Assembler::State.new(ax: 3, bx: 1)
        command = described_class.new("ax", [:register, "bx"])
        expect(command.execute(initial_state)).to eq_state(ax: 2, bx: 1, cx: 0, dx: 0)
      end
    end

    context "with an invalid expression" do
      it "throws an exception" do
        initial_state = Assembler::State.new
        command = described_class.new("ax", [:nope, 5])
        expect { command.execute(initial_state) }.to raise_error(Assembler::InterpreterException)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Assembler::Commands::Add do
  describe "#execute" do
    context "with a constant" do
      it "adds the constant into the register" do
        initial_state = Assembler::State.new(ax: 2)
        command = described_class.new("ax", [:constant, 5])
        expect(command.execute(initial_state)).to eq_state(ax: 7, bx: 0, cx: 0, dx: 0)
      end
    end

    context "with a second register" do
      it "adds the value of the second register into the first" do
        initial_state = Assembler::State.new(ax: 2, bx: 3)
        command = described_class.new("ax", [:register, "bx"])
        expect(command.execute(initial_state)).to eq_state(ax: 5, bx: 3, cx: 0, dx: 0)
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

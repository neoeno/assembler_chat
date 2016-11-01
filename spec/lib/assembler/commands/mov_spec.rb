require 'rails_helper'

RSpec.describe Assembler::Commands::Mov do
  describe "#execute" do
    it "modifies the given state" do
      initial_state = Assembler::State.new
      command = described_class.new("ax", [:constant, 5])
      expect(command.execute(initial_state).to_h).to eq({
        "ax" => 5,
        "bx" => 0,
        "cx" => 0,
        "dx" => 0
      })
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

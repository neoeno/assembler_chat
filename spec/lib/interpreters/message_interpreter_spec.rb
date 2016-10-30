require 'rails_helper'
require 'support/string_length_accumulation_engine';

RSpec.describe Interpreters::MessageInterpreter do
  let(:engine) { StringLengthAccumulationEngine.new }
  subject { described_class.new(engine) }

  describe "#initial_state" do
    it "delegates to engine" do
      expect(subject.initial_state).to eq engine.initial_state
    end
  end

  describe "#interpret" do
    it "returns the new state based on the statement given" do
      state = subject.initial_state
      state_2 = subject.interpret(state, "hello, this is a message!")
      expect(state_2).to eq({total_length: 25})
    end

    it "can iterate over a second state" do
      state = subject.initial_state
      state_2 = subject.interpret(state, "hello, this is a message!")
      state_3 = subject.interpret(state, "woo")
      expect(state_3).to eq({total_length: 28})
    end
  end
end

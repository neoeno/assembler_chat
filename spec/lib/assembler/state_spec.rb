require 'rails_helper'

RSpec.describe Assembler::State do
  EXAMPLE_STATE = {"ax" => 1, "bx" => 2, "cx" => 3, "dx" => 4}.freeze

  shared_examples :register_with_value do |method, value|
    it "defaults to #{value}" do
      expect(subject.send(method)).to eq value
    end
  end

  describe "#generate" do
    it "provides a hash to be modified and returns a new state with the changes" do
      new_state = subject.generate do |state|
        state["ax"] = 5
      end
      expect(new_state.ax).to eq 5
    end

    it "leaves the existing state as it is" do
      subject.generate do |state|
        state["ax"] = 5
      end
      expect(subject.ax).to eq 0
    end
  end

  describe "#to_h" do
    subject { described_class.new(EXAMPLE_STATE) }

    it "returns a representative hash" do
      expect(subject.to_h).to eq(EXAMPLE_STATE)
    end
  end

  describe "#to_s" do
    subject { described_class.new(EXAMPLE_STATE) }

    it "returns a representative string" do
      expect(subject.to_s).to eq("{\"ax\"=>1, \"bx\"=>2, \"cx\"=>3, \"dx\"=>4}")
    end
  end

  describe "#get_state" do
    subject { described_class.new("ax" => 5)}
    it "gets the state with the key of the arg (string)" do
      expect(subject.get_state("ax")).to eq 5
    end

    it "gets the state with the key of the arg (symbol)" do
      expect(subject.get_state(:ax)).to eq 5
    end
  end

  describe "#ax" do
    it_behaves_like :register_with_value, :ax, 0
  end

  describe "#bx" do
    it_behaves_like :register_with_value, :bx, 0
  end

  describe "#cx" do
    it_behaves_like :register_with_value, :cx, 0
  end

  describe "#dx" do
    it_behaves_like :register_with_value, :dx, 0
  end

  context "with an initial state hash" do
    subject { described_class.new(EXAMPLE_STATE) }

    describe "#ax" do
      it_behaves_like :register_with_value, :ax, 1
    end

    describe "#bx" do
      it_behaves_like :register_with_value, :bx, 2
    end

    describe "#cx" do
      it_behaves_like :register_with_value, :cx, 3
    end

    describe "#dx" do
      it_behaves_like :register_with_value, :dx, 4
    end
  end

  it "doesn't respond to any random method" do
    expect(subject.respond_to? :fefawfewewafw).to be_falsey
  end
end

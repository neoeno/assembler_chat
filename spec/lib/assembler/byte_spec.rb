require 'rails_helper'

RSpec.describe Assembler::Byte do
  describe ".from_i" do
    it "converts an integer to itself" do
      expect(described_class.from_i(5).bits).to eq [0,0,0,0,0,1,0,1]
    end

    it "cycles round at 256" do
      expect(described_class.from_i(256).bits).to eq [0,0,0,0,0,0,0,0]
    end

    it "represents negatives with 2's complement" do
      expect(described_class.from_i(-5).bits).to eq [1,1,1,1,1,0,1,1]
    end
  end

  describe "#to_i" do
    it "converts itself to an integer" do
      expect(described_class.from_i(5).to_i).to eq 5
    end

    it "acts without regard for negative numbers" do
      expect(described_class.from_i(-5).to_i).to eq 251
    end
  end

end

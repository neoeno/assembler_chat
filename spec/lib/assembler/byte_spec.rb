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

  describe "#bits" do
    it "returns the bits of the number" do
      expect(described_class.from_i(5).bits).to eq [0,0,0,0,0,1,0,1]
    end
  end

  describe "#-" do
    it "subtracts" do
      expect(described_class.from_i(5) - 4).to eq Assembler::Byte.from_i(1)
    end

    it "subtracts below zero and cycles around" do
      expect(described_class.from_i(5) - 6).to eq Assembler::Byte.from_i(255)
    end
  end

  describe "#+" do
    it "adds" do
      expect(described_class.from_i(5) + 4).to eq Assembler::Byte.from_i(9)
    end
  end

  describe "#==" do
    it "compares two matching bytes" do
      expect(described_class.from_i(1)).to eq described_class.from_i(1)
    end

    it "compares two non-matching bytes" do
      expect(described_class.from_i(2)).to_not eq described_class.from_i(1)
    end

    it "refuses to compare integers" do
      expect(described_class.from_i(1)).to_not eq 1
    end
  end

  describe "#as_json" do
    it "returns a bit array" do
      expect(described_class.from_i(5).as_json).to eq [0,0,0,0,0,1,0,1]
    end
  end

  describe "#to_s" do
    it "returns a string of bits" do
      expect(described_class.from_i(5).to_s).to eq "00000101"
    end
  end

  describe "#inspect" do
    it "returns a helpful debugging string of bits" do
      expect(described_class.from_i(5).inspect).to eq "BYTE[00000101, 5]"
    end
  end

  describe ".integer_to_bits" do
    it "returns the bit representation of an integer" do
      expect(described_class.integer_to_bits(5)).to eq [0,0,0,0,0,1,0,1]
    end
  end

  describe ".bits_to_integer" do
    it "returns the integer representation of a bit array" do
      expect(described_class.bits_to_integer([0,0,0,0,0,1,0,1])).to eq 5
    end
  end

end

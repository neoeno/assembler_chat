require 'rails_helper'

RSpec.describe Assembler::Word do
  describe ".from_i" do
    it "converts an integer to itself" do
      expect(described_class.from_i(5).bits).to eq [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1]
    end

    it "cycles round at 65536" do
      expect(described_class.from_i(65536).bits).to eq [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    end

    it "represents negatives with 2's complement" do
      expect(described_class.from_i(-5).bits).to eq [1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1]
    end
  end

  describe "#to_i" do
    it "converts itself to an integer" do
      expect(described_class.from_i(5).to_i).to eq 5
    end

    it "acts without regard for negative numbers" do
      expect(described_class.from_i(-5).to_i).to eq 65531
    end
  end

  describe "#bits" do
    it "returns the bits of the number" do
      expect(described_class.from_i(5).bits).to eq [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1]
    end
  end

  describe "#-" do
    it "subtracts" do
      expect(described_class.from_i(5) - 4).to eq Assembler::Word.from_i(1)
    end

    it "subtracts below zero and cycles around" do
      expect(described_class.from_i(5) - 6).to eq Assembler::Word.from_i(65535)
    end
  end

  describe "#+" do
    it "adds" do
      expect(described_class.from_i(5) + 4).to eq Assembler::Word.from_i(9)
    end
  end

  describe "#==" do
    it "compares two matching words" do
      expect(described_class.from_i(1)).to eq described_class.from_i(1)
    end

    it "compares two non-matching words" do
      expect(described_class.from_i(2)).to_not eq described_class.from_i(1)
    end

    it "refuses to compare integers" do
      expect(described_class.from_i(1)).to_not eq 1
    end
  end

  describe "#as_json" do
    it "returns a bit array" do
      expect(described_class.from_i(5).as_json).to eq [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1]
    end
  end

  describe "#to_s" do
    it "returns a hex string" do
      expect(described_class.from_i(5).to_s).to eq "0005h"
    end
  end

  describe "#inspect" do
    it "returns a helpful debugging hex string" do
      expect(described_class.from_i(5).inspect).to eq "WORD[0005h, 5]"
    end
  end

  describe ".integer_to_bits" do
    it "returns the bit representation of an integer" do
      expect(described_class.integer_to_bits(5)).to eq [0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1]
    end
  end

  describe ".bits_to_integer" do
    it "returns the integer representation of a bit array" do
      expect(described_class.bits_to_integer([0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1])).to eq 5
    end
  end

end

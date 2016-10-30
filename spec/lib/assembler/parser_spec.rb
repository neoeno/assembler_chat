require 'rails_helper'

RSpec.describe Assembler::Parser do
  describe ".parse" do
    it "lexes mov statements" do
      statement = "mov ax, 1d"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["mov", "ax", 1]
    end
  end
end

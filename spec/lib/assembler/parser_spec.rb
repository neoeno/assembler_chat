require 'rails_helper'

RSpec.describe Assembler::Parser do
  describe ".parse" do
    it "parses mov statements" do
      statement = "mov ax, 1d"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["mov", "ax", [:constant, 1]]
    end

    it "parses mov statements with two registers" do
      statement = "mov ax, bx"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["mov", "ax", [:register, "bx"]]
    end
  end
end

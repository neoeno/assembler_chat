require 'rails_helper'

RSpec.describe Assembler::Parser do
  describe ".parse" do
    it "parses arity-1 statements" do
      statement = "inc ax"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["inc", "ax"]
    end

    it "parses arity-2 statements" do
      statement = "mov ax, 1d"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["mov", "ax", [:constant, 1]]
    end

    it "parses arity-2 statements with two registers" do
      statement = "mov ax, bx"
      parsed = described_class.parse(Assembler::Lexer.lex(statement))
      expect(parsed).to eq ["mov", "ax", [:register, "bx"]]
    end
  end
end

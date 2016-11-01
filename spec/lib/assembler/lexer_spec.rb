require 'rails_helper'

RSpec.describe Assembler::Lexer do
  def lexed_to_comparable(lexed)
    lexed.map { |token| [token.type, token.value].compact }
  end

  describe ".lex" do
    it "lexes arity-1 statements" do
      statement = "INC AX"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:COMMAND_1, "inc"],
        [:REGISTER, "ax"],
        [:EOS]
      ]
    end

    it "lexes arity-2 statements" do
      statement = "MOV AX, 1d"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:COMMAND_2, "mov"],
        [:REGISTER, "ax"],
        [:ARGUMENT_SEPARATOR],
        [:NUMBER, 1],
        [:EOS]
      ]
    end

    it "lexes decimal numbers" do
      statement = "10d"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:NUMBER, 10],
        [:EOS]
      ]
    end

    it "lexes decimal numbers without the d suffix" do
      statement = "10"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:NUMBER, 10],
        [:EOS]
      ]
    end

    it "lexes octal numbers" do
      statement = "17o"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:NUMBER, 15],
        [:EOS]
      ]
    end

    it "lexes hex numbers" do
      statement = "1Ah"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:NUMBER, 26],
        [:EOS]
      ]
    end

    it "lexes binary numbers" do
      statement = "0101b"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:NUMBER, 5],
        [:EOS]
      ]
    end
  end
end

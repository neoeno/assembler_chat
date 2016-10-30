require 'rails_helper'

RSpec.describe Assembler::Lexer do
  def lexed_to_comparable(lexed)
    lexed.map { |token| [token.type, token.value].compact }
  end

  describe ".lex" do
    it "lexes mov statements" do
      statement = "MOV AX, 1d"
      lexed = described_class.lex(statement)
      expect(lexed_to_comparable(lexed)).to eq [
        [:COMMAND, "mov"],
        [:REGISTER, "ax"],
        [:ARGUMENT_SEPARATOR],
        [:NUMBER, 1],
        [:EOS]
      ]
    end
  end
end

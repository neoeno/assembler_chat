class Assembler::Lexer < RLTK::Lexer
  rule(/[a-z]{3}/i)       { |c| [:COMMAND, c.downcase] }
  rule(/[a-z]{2}/i) { |r| [:REGISTER, r.downcase] }
  rule(/,/)         { :ARGUMENT_SEPARATOR }
  rule(/[0-9]+d/i)  { |n| [:NUMBER, n.to_i] } # #to_i skips off the 'd'

  rule(/\s/)
end

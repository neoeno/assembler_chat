class Assembler::Lexer < RLTK::Lexer
  rule(/mov/i)     { |c| [:COMMAND, c.downcase] }
  rule(/[a-d]x/i)  { |r| [:REGISTER, r.downcase] }
  rule(/,/)        { :ARGUMENT_SEPARATOR }
  rule(/[0-9]+d/i) { |n| [:NUMBER, n.to_i] } # #to_i skips off the 'd'

  rule(/\s/)
end

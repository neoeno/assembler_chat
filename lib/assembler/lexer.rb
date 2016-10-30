class Assembler::Lexer < RLTK::Lexer
  rule(/inc/i)     { |c| [:COMMAND_1, c.downcase] }
  rule(/mov/i)     { |c| [:COMMAND_2, c.downcase] }
  rule(/[a-d]x/i)  { |r| [:REGISTER, r.downcase] }
  rule(/,/)        { :ARGUMENT_SEPARATOR }
  rule(/[0-9]+d/i) { |n| [:NUMBER, n.to_i] } # #to_i skips off the 'd'

  rule(/\s/)
end

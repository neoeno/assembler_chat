class Assembler::Lexer < RLTK::Lexer
  rule(/inc|dec/i)     { |c| [:COMMAND_1, c.downcase] }
  rule(/mov|add|sub/i) { |c| [:COMMAND_2, c.downcase] }
  rule(/[a-d]x/i)      { |r| [:REGISTER, r.downcase] }

  rule(/,/)            { :ARGUMENT_SEPARATOR }

  rule(/[0-1]+b/i)     { |n| [:NUMBER, n.to_i(2)] }  # #to_i skips off suffixes for us
  rule(/[0-9A-F]+h/i)  { |n| [:NUMBER, n.to_i(16)] }
  rule(/[0-7]+o/i)     { |n| [:NUMBER, n.to_i(8)] }
  rule(/[0-9]+d?/i)    { |n| [:NUMBER, n.to_i] }

  rule(/\s/)
end

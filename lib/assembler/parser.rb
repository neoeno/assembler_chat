class Assembler::Parser < RLTK::Parser
  production(:e) do
    clause('COMMAND REGISTER ARGUMENT_SEPARATOR expression') do |command, register, _, number|
      [command, register, number]
    end
  end

  production(:expression) do
    clause('REGISTER') { |r| [:register, r] }
    clause('NUMBER')   { |n| [:constant, n] }
  end

  finalize
end

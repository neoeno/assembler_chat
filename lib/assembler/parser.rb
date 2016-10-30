class Assembler::Parser < RLTK::Parser
  production(:statement) do
    clause('COMMAND_2 REGISTER ARGUMENT_SEPARATOR expression') do |command, register, _, number|
      [command, register, number]
    end

    clause('COMMAND_1 REGISTER') do |command, register|
      [command, register]
    end
  end

  production(:expression) do
    clause('REGISTER') { |r| [:register, r] }
    clause('NUMBER')   { |n| [:constant, n] }
  end

  finalize
end

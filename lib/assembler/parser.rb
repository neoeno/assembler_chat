class Assembler::Parser < RLTK::Parser
  production(:e) do
    clause('COMMAND REGISTER ARGUMENT_SEPARATOR NUMBER') do |command, register, _, number|
      [command, register, number]
    end
  end

  finalize
end

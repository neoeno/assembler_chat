class Assembler::Interpreter
  def initial_state
    {
      ax: 0,
      bx: 0,
      cx: 0,
      dx: 0
    }
  end

  def interpret(state, statement)
    lexed = Assembler::Lexer.lex(statement)
    parsed = Assembler::Parser.parse(lexed)
    Assembler::Executor.execute(state, parsed)
  end
end

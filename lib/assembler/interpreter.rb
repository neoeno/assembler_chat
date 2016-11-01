class Assembler::Interpreter
  def initial_state
    Assembler::State.new.to_h
  end

  def interpret(state, statement)
    state = Assembler::State.new(state)
    Assembler::Executor.execute(state, parse(lex(statement))).to_h
  end

  private def lex(statement)
    begin
      Assembler::Lexer.lex(statement)
    rescue RLTK::LexingError => e
      raise Assembler::InterpreterException.new(e)
    end
  end

  private def parse(lexed)
    begin
      Assembler::Parser.parse(lexed)
    rescue RLTK::NotInLanguage => e
      raise Assembler::InterpreterException.new(e)
    end
  end
end

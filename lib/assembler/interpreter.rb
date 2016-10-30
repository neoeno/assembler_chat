class Assembler::Interpreter
  def initial_state
    {
      "ax" => 0,
      "bx" => 0,
      "cx" => 0,
      "dx" => 0
    }
  end

  def interpret(state, statement)
    Assembler::Executor.execute(state, parse(lex(statement)))
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

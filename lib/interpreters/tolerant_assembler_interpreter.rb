class Interpreters::TolerantAssemblerInterpreter < Interpreters::AbstractInterpreter
  def initialize
    @engine = Assembler::Interpreter.new
  end

  def interpret(state, statement)
    begin
      @engine.interpret(state, statement)
    rescue Assembler::InterpreterException => e
      state
    end
  end
end

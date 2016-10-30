# An assembler interpreter that swallows all exceptions
# So our chat messages just fail to do anything, rather
# than cause errors

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

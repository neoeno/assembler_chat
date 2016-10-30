class Assembler::Commands::Mov
  def initialize(dest, src)
    @dest = dest
    @source = src
  end

  def execute(state)
    state[@dest] = evaluate_expression(state, @source)
    state
  end


  private def evaluate_expression(state, expression)
    if expression[0] == :register then
      # If this is a register we need to fetch it from state
      return state[expression[1]]
    elsif expression[0] == :constant
      # If it's a constant we can use it straight
      expression[1]
    else
      raise Assembler::InterpreterException.new("Invalid expression: " + expression.try(:to_s))
    end
  end
end

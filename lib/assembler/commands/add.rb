class Assembler::Commands::Add
  def initialize(dest, src)
    @dest = dest
    @source = src
  end

  def execute(state)
    state.generate do |s|
      s[@dest] += evaluate_expression(state, @source)
    end
  end


  private def evaluate_expression(state, expression)
    if expression[0] == :register then
      # If this is a register we need to fetch it from state
      return state.get(expression[1])
    elsif expression[0] == :constant
      # If it's a constant we can use it straight
      expression[1]
    else
      raise Assembler::InterpreterException.new("Invalid expression: " + expression.try(:to_s))
    end
  end
end

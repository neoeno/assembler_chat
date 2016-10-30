class Interpreters::AbstractInterpreter
  def initial_state
    @engine.initial_state
  end

  def interpret(state, statement)
    @engine.interpret(state, statement)
  end
end

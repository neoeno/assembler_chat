class Interpreters::MessageInterpreter
  def initialize(engine)
    @engine = engine
  end

  def initial_state
    @engine.initial_state
  end

  def interpret(state, message)
    @engine.interpret(state, message)
  end
end

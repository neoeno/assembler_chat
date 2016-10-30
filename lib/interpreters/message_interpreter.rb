class Interpreters::MessageInterpreter < Interpreters::AbstractInterpreter
  def initialize(engine)
    @engine = engine
  end
end

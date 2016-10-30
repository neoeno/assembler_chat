class Assembler::Commands::Dec
  def initialize(register)
    @register = register
  end

  def execute(state)
    state[@register] -= 1
    state
  end
end

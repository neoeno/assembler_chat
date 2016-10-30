class Assembler::Commands::Inc
  def initialize(register)
    @register = register
  end

  def execute(state)
    state[@register] += 1
    state
  end
end

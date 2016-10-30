class Assembler::Commands::Mov
  def initialize(register, value)
    @register = register.to_sym
    @value = value
  end

  def execute(state)
    state[@register] = @value
    state
  end
end

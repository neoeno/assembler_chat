class Assembler::Commands::Dec
  def initialize(register)
    @register = register
  end

  def execute(state)
    state.generate do |s|
      s[@register] -= 1
    end
  end
end

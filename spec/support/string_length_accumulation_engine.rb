class StringLengthAccumulationEngine
  def initial_state
    {
      total_length: 0
    }
  end

  def interpret(state, statement)
    state[:total_length] += statement.length
    state
  end
end

class Assembler::Executor
  # We keep a manual index here as letting user input dictate classes is
  # a bit of a worry security-wise
  COMMANDS = {
    "mov" => Assembler::Commands::Mov
  }.freeze

  def self.execute(state, statement)
    COMMANDS[statement[0]] # Select command
      .new(statement[1], statement[2]) # Apply arguments
      .execute(state) # Execute on state
  end
end

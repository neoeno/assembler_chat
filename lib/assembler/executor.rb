class Assembler::Executor
  # We keep a manual index here as letting user input dictate classes is
  # a bit of a worry security-wise
  COMMANDS = {
    "mov" => Assembler::Commands::Mov,
    "inc" => Assembler::Commands::Inc
  }.freeze

  def self.execute(state, statement)
    command = statement[0]
    arguments = statement[1..-1]
    COMMANDS[command] # Select command
      .new(*arguments) # Apply arguments
      .execute(state) # Execute on state
  end
end

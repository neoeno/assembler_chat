RSpec.shared_context "assembler_utils" do
  let(:interpreter) { Assembler::Interpreter.new }
  StateDiff = Struct.new(:state_before, :state_after)

  def initial_state(modifications={})
    interpreter.initial_state.merge(modifications)
  end

  def execute(state, statement)
    begin
      StateDiff.new(
        state,
        interpreter.interpret(state, statement)
      )
    rescue Assembler::InterpreterException => e
      return e
    end
  end

  RSpec::Matchers.define :set_registers do |expected|
    expected = expected.stringify_keys
    match do |actual|
      return false unless actual.is_a? StateDiff
      actual.state_after.all? do |key, value|
        comparison_value = expected.fetch(key, actual.state_before[key])
        actual.state_after[key] == comparison_value
      end
    end
  end

  RSpec::Matchers.define :raise_interpreter_error do
    match do |actual|
      return true if actual.is_a? Assembler::InterpreterException
    end
  end
end

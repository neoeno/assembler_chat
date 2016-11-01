class Assembler::State
  DEFAULT_STATE = {"ax" => 0, "bx" => 0, "cx" => 0, "dx" => 0}.freeze

  def initialize(initial_state = {})
    initialize_state!(initial_state)
  end

  def generate
    new_state = @state.dup
    yield new_state
    return self.class.new(new_state)
  end

  def get(key)
    @state[key.to_s]
  end

  def method_missing(method, *args)
    return get(method) if @state.has_key?(method.to_s)
    super
  end

  def respond_to?(method)
    return true if @state.has_key?(method.to_s)
    super
  end

  def to_h
    @state.dup
  end

  def to_s
    to_h.to_s
  end

  private def initialize_state!(initial_state)
    @state = DEFAULT_STATE.merge(initial_state.stringify_keys).freeze
  end
end

class Assembler::State
  DEFAULT_STATE = {
    "ax" => Assembler::Word.new,
    "bx" => Assembler::Word.new,
    "cx" => Assembler::Word.new,
    "dx" => Assembler::Word.new
  }.freeze

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

  def inspect
    to_h.to_s
  end

  private def initialize_state!(initial_state)
    initial_state = initial_state.stringify_keys
    initial_state = initial_state.map do |key, value|
      if value.is_a? Assembler::Word
        [key, value]
      elsif value.is_a? Array
        [key, Assembler::Word.new(value)]
      else
        [key, Assembler::Word.from_i(value)]
      end
    end.to_h
    @state = DEFAULT_STATE.merge(initial_state).freeze
  end
end

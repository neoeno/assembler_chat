RSpec::Matchers.define :eq_state do |expected|
  match do |actual|
    actual_hash = actual.to_h.map { |k, v| [k, v.to_i] }.to_h
    expected.stringify_keys == actual_hash
  end
end

def byte_to_i(value) # different method to state class to avoid false positives
  return value.join.to_i(2)
end

def i_to_byte(value) # https://www.ruby-forum.com/topic/12247 (different method to avoid false-positives)
  value.to_s(2).rjust(8, "0").split("").map(&:to_i)
end

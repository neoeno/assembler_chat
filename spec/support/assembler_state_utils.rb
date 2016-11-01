RSpec::Matchers.define :eq_state do |expected|
  match do |actual|
    expected.stringify_keys == actual.to_h
  end
end

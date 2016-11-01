class Assembler::Byte
  LENGTH = 8

  def initialize(bits)
    @bits = bits
  end

  def bits
    @bits.dup
  end

  def self.from_i(n) # https://www.ruby-forum.com/topic/12247 thanks james
    # turns out Integer#[ gets you the bit value at that index. I think?
    bits = Array.new(LENGTH) { |i| n[i] }.reverse!
    self.new(bits)
  end

  def to_i # http://stackoverflow.com/a/10770876
    # No such luck the other way around tho. This uses bitwise or and bit shift
    # to build up the right byte as an integer
    @bits.reverse.each_with_index.reduce(0) do |memo, (val, idx)|
      memo |= val << idx
    end
  end
end

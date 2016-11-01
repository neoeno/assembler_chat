class Assembler::Byte
  LENGTH = 8

  def self.from_i(integer)
    new(integer_to_bits(integer))
  end

  def initialize(bits=[0,0,0,0,0,0,0,0])
    @integer = self.class.bits_to_integer(bits) # Ha! Fooled you
  end

  def bits
    self.class.integer_to_bits(@integer)
  end

  def -(obj)
    Assembler::Byte.from_i(@integer - obj.to_i)
  end

  def +(obj)
    Assembler::Byte.from_i(@integer + obj.to_i)
  end

  def ==(obj)
    @integer == obj
  end

  def as_json(_)
    bits
  end

  def to_s
    @integer.to_s
  end

  def inspect
    @integer.inspect
  end

  def to_i
    @integer
  end

  def self.integer_to_bits(integer) # https://www.ruby-forum.com/topic/12247 thanks james
    # turns out Integer#[ gets you the bit value at that index. I think?
    Array.new(LENGTH) { |i| integer[i] }.reverse!
  end

  def self.bits_to_integer(bits) # http://stackoverflow.com/a/10770876
    # No such luck the other way around tho. This uses bitwise or and bit shift
    # to build up the right byte as an integer
    bits.reverse.each_with_index.reduce(0) do |memo, (val, idx)|
      memo |= val << idx
    end
  end
end

require 'rails_helper'

RSpec.describe "Assembler Integration" do
  include_context "assembler_utils"

  describe "mov" do
    it "moves values from constant value to register" do
      expect(execute(initial_state, "mov AX, 5d")).to set_registers(ax: 5)
    end

    it "moves values from register to register" do
      expect(execute(initial_state(bx: 3), "mov AX, BX")).to set_registers(ax: 3, bx: 3)
    end

    it "cannot move a value into a constant" do
      expect(execute(initial_state(bx: 3), "mov 5d, BX")).to raise_interpreter_error
    end
  end

  describe "inc" do
    it "increments zero registers" do
      expect(execute(initial_state, "inc AX")).to set_registers(ax: 1)
    end

    it "increments non-zero registers" do
      expect(execute(initial_state(ax: 1), "inc AX")).to set_registers(ax: 2)
    end

    it "cannot increment constants" do
      expect(execute(initial_state, "inc 5d")).to raise_interpreter_error
    end
  end

  describe "dec" do
    it "decrements zero registers" do
      expect(execute(initial_state, "dec AX")).to set_registers(ax: 255)
    end

    it "decrements non-zero registers" do
      expect(execute(initial_state(ax: 1), "dec AX")).to set_registers(ax: 0)
    end

    it "cannot decrement constants" do
      expect(execute(initial_state, "dec 5d")).to raise_interpreter_error
    end
  end

  describe "add" do
    it "adds constant values to a register" do
      expect(execute(initial_state(ax: 1), "add AX, 5d")).to set_registers(ax: 6)
    end

    it "adds register values to a register" do
      expect(execute(initial_state(ax: 1, bx: 3), "add AX, BX")).to set_registers(ax: 4, bx: 3)
    end

    it "cannot add a value into a constant" do
      expect(execute(initial_state, "add 5d, BX")).to raise_interpreter_error
    end
  end

  describe "sub" do
    it "subtracts constant values from a register" do
      expect(execute(initial_state(ax: 5), "sub AX, 4d")).to set_registers(ax: 1)
    end

    it "subtracts register values from a register" do
      expect(execute(initial_state(ax: 5, bx: 3), "sub AX, BX")).to set_registers(ax: 2, bx: 3)
    end

    it "wraps negative values round to positives" do
      expect(execute(initial_state(ax: 1, bx: 3), "sub AX, BX")).to set_registers(ax: 254, bx: 3)
    end

    it "cannot subtract a value from a constant" do
      expect(execute(initial_state, "sub 5d, BX")).to raise_interpreter_error
    end
  end
end

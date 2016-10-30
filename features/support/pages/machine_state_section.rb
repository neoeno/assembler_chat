class MachineStateSection < SitePrism::Section
  element :register_ax, ".test-register-ax"
  element :register_bx, ".test-register-bx"
  element :register_cx, ".test-register-cx"
  element :register_dx, ".test-register-dx"

  def register(name)
    case name.downcase
      when "ax"
        register_ax
      when "bx"
        register_bx
      when "cx"
        register_cx
      when "dx"
        register_dx
    end
  end
end

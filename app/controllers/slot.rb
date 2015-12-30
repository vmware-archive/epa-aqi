class Slot
  attr_reader :type
  def initialize(type=:empty)
    @type = type
  end

  def ==(other_slot)
    type == other_slot.type
  end
end
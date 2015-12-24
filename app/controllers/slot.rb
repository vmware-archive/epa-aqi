class Slot
  attr_reader :type, :label
  def initialize(type=:empty, label='')
    @type = type
    @label = label
  end

  def ==(other_slot)
    self.type == other_slot.type &&
        self.label == other_slot.label
  end
end
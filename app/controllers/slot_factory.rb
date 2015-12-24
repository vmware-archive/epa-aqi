
class SlotFactory
  def for_grades(epa_grade, user_grade)
    ('A'..'F').map do |slot_grade|
      if slot_grade == epa_grade
        if epa_grade == user_grade
          Slot.new(:two_pin, 'You and EPA')
        else
          Slot.new(:one_pin, 'EPA')
        end
      elsif slot_grade == user_grade
        if epa_grade == user_grade
          Slot.new(:two_pin, 'You and EPA')
        else
          Slot.new(:one_pin, 'You')
        end
      else
        Slot.new(:empty, '')
      end
    end
  end
end
class SlotFactory
  def for_grades(epa_grade, user_grade)
    ('A'..'F').map do |slot_grade|
      if slot_grade == epa_grade
        slot = Slot.new(:one_pin, 'EPA')
      end
      if slot_grade == user_grade
        slot = Slot.new(:one_pin, 'You')
      end
      if slot_grade == epa_grade && slot_grade == user_grade
        slot = Slot.new(:two_pin, 'You and EPA')
      end

      slot || Slot.new(:empty, nil)
    end
  end
end
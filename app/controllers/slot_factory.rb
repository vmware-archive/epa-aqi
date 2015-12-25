class SlotFactory
  def for_grades(epa_aqg, user_aqg)
    ('A'..'F').map do |slot_grade|
      if slot_grade == epa_aqg.grade
        slot = Slot.new(:one_pin, 'EPA')
      end
      if slot_grade == user_aqg.grade
        slot = Slot.new(:one_pin, 'You')
      end
      if slot_grade == epa_aqg.grade && slot_grade == user_aqg.grade
        slot = Slot.new(:two_pin, 'You and EPA')
      end

      slot || Slot.new(:empty, nil)
    end
  end
end
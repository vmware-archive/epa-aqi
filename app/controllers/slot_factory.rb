class SlotFactory
  def for_grades(epa_aqg, user_aqg)
    ('A'..'F').map do |slot_grade|
      if slot_grade == epa_aqg.grade
        slot = Slot.new(:epa_pin)
      end
      if slot_grade == user_aqg.grade
        slot = Slot.new(:you_pin)
      end
      if slot_grade == epa_aqg.grade && slot_grade == user_aqg.grade
        slot = Slot.new(:match_pin)
      end

      slot || Slot.new(:empty)
    end
  end
end
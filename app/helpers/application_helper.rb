module ApplicationHelper
  TYPE_TO_CLASS = {
      you_pin: 'you-pin',
      epa_pin: 'epa-pin',
      match_pin: 'match-pin'
  }
  SLOT_WIDTHS = [10, 10, 10, 10, 20, 40]

  def slot_widths
    SLOT_WIDTHS
  end

  def slot_type_to_css_class(slot_type)
    TYPE_TO_CLASS[slot_type] || 'empty-slot'
  end

  def grade_to_css_class(grade)
    "grade-#{grade.grade.try(:downcase)}"
  end

end

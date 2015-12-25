module ApplicationHelper
  TYPE_TO_CLASS = {
      one_pin: 'single-pin',
      two_pin: 'multiple-pins'
  }
  SLOT_WIDTHS = [10, 10, 10, 10, 20, 40]

  def slot_widths
    SLOT_WIDTHS
  end

  def slot_type_to_css_class(slot_type)
    TYPE_TO_CLASS[slot_type] || 'empty-slot'
  end
end

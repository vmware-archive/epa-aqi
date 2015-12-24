module ApplicationHelper
  TYPE_TO_CLASS = {
      one_pin: 'single-pin',
      two_pin: 'multiple-pins'
  }

  def slot_type_to_css_class(slot_type)
    TYPE_TO_CLASS[slot_type] || 'empty-slot'
  end
end

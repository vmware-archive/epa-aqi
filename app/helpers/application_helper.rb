module ApplicationHelper
  def slot_type_to_css_class(slot_type)
    if slot_type == :one_pin
      'single-pin'
    elsif slot_type == :two_pin
      'multiple-pins'
    elsif slot_type == :empty || slot_type.nil?
      'empty-slot'
    end
  end
end

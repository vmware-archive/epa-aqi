class AirQualityGradeCalculator
  def epa_service(impl=EpaService.new)
    @epa_service ||= impl
  end

  def for_zipcode(zipcode)
    measures = epa_service.get_measures_for_zipcode(zipcode)
    measure = find_least_healthy_measure(measures)
    grade_for_category_number(measure['Category']['Number'])
  end


  private
  def grade_for_category_number(category_number)
    case category_number
      when 1
        'A'
      when 2
        'B'
      when 3
        'C'
      when 4
        'D'
      when 5
        'E'
      when 6
        'F'
      else
        '(unrecognized category number)'
    end
  end
  def find_least_healthy_measure(measures)
    measures.max_by { |measure| measure['AQI'] }
  end
end
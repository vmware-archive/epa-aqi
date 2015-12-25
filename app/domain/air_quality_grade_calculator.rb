class AirQualityGradeCalculator
  def epa_service(impl=EpaService.new)
    @epa_service ||= impl
  end

  def for_zipcode(zipcode)
    measures = epa_service.get_measures_for_zipcode(zipcode)
    measure = find_least_healthy_measure(measures)
    AirQualityGrade.new(measure)
  end

  private
  def find_least_healthy_measure(measures)
    measures.max_by { |measure| measure['AQI'] }
  end
end


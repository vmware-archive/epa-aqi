class AirQualityGradeCalculator
  def grade_for(measures)
    measure = find_least_healthy_measure(measures)
    AirQualityGrade.new(measure)
  end

  private
  def find_least_healthy_measure(measures)
    measures.max_by { |measure| measure['AQI'] }
  end
end


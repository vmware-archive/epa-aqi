class AirQualityGrade
  attr_reader :aqi, :grade

  GRADE_FOR_CATEGORY_NUMBER = { 1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E', 6 => 'F' }

  def initialize(measure_or_grade)
    if is_a_measure?(measure_or_grade)
      measure = measure_or_grade
      @aqi = measure['AQI']
      @grade = GRADE_FOR_CATEGORY_NUMBER[measure['Category']['Number']] || 'X'
    else
      @aqi = nil
      @grade = measure_or_grade || 'X'
    end
  end

  def is_a_measure?(measure_or_grade)
    measure_or_grade.is_a?(Hash)
  end

  def ==(other_aqg)
    aqi == other_aqg.aqi && grade == other_aqg.grade
  end
end
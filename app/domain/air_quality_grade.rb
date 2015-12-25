class AirQualityGrade
  attr_reader :aqi, :grade
  def initialize(measure_or_grade)
    if measure_or_grade.is_a?(Hash)
      @aqi = measure_or_grade['AQI']
      @grade = grade_for_category_number(measure_or_grade['Category']['Number'])
    else
      @aqi = nil
      @grade = measure_or_grade
    end

  end

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

  def ==(other_aqg)
    self.aqi == other_aqg.aqi && self.grade == other_aqg.grade
  end
end
class EpaData
  attr_reader :grade, :measures

  def initialize(grade, measures)
    @grade = grade
    @measures = measures
  end

  def ==(other_epa_data)
    other_epa_data.grade == grade &&
        other_epa_data.measures == measures
  end
end
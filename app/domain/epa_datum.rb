class EpaDatum
  attr_reader :parameter_name, :aqi, :aqi_average

  def initialize(parameter_name, aqi, aqi_average)
    @parameter_name = parameter_name
    @aqi = aqi
    @aqi_average = aqi_average
  end

  def ==(other_epa_datum)
    other_epa_datum.parameter_name == parameter_name &&
        other_epa_datum.aqi == aqi &&
        other_epa_datum.aqi_average == aqi_average
  end
end
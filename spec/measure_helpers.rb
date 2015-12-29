module MeasureHelpers
  def generate_measure_json_of_category(aqi_score, number, name, parameter_name="O3")
    "{
    \"ParameterName\": \"#{parameter_name}\",
    \"AQI\": #{aqi_score},
    \"Category\": {
      \"Number\": #{number},
      \"Name\": \"#{name}\"
    }
  }"
  end

  def generate_measure_of_category(aqi_score, number, name)
    JSON.parse(generate_measure_json_of_category(aqi_score, number, name))
  end

  def generate_measures_of_category(aqi_score, number, name, parameter_name="O3")
    JSON.parse('[' + generate_measure_json_of_category(aqi_score, number, name, parameter_name)+']')
  end
end
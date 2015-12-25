module MeasureHelpers
  def generate_measure_json_of_category(aqi_score, number, name)
    "{
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

  def generate_measures_of_category(aqi_score, number, name)
    JSON.parse('[' + generate_measure_json_of_category(aqi_score, number, name)+']')
  end
end
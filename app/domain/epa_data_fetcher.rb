class EpaDataFetcher
  CHEMICAL_TO_DISPLAY_NAME = {
      'O3' => 'Ground-Level Ozone',
      'PM2.5' => 'Fine <br>Particles'.html_safe,
      'PM10' => 'Coarse Dust Particles',
      'CO' => 'Carbon Monoxide',
      'SO2' => 'Sulfur <br>Dioxide'.html_safe,
      'NO2' => 'Nitrogen Dioxide',
  }

  def epa_service(impl=EpaService.new)
    @epa_service ||= impl
  end

  def aqg_calculator(impl=AirQualityGradeCalculator.new)
    @aqg_calculator ||= impl
  end

  def for_zipcode(zipcode)
    measures = epa_service.get_measures_for_zipcode(zipcode)
    epa_aqg = aqg_calculator.grade_for(measures)

    EpaData.new(epa_aqg, present(measures))
  end

  private
  def present(measures)
    epa_datums = epa_datums_for_measures(measures)
    list_missing_measures = missing_measures(measures)
    epa_datums.concat(empty_epa_datums(list_missing_measures))
  end

  def epa_datums_for_measures(measures)
    measures.map { |measure|
      display_name = CHEMICAL_TO_DISPLAY_NAME[measure['ParameterName']]
      aqi = measure['AQI']
      EpaDatum.new(display_name, aqi, nil) if display_name
    }.compact
  end

  def missing_measures(measures)
    CHEMICAL_TO_DISPLAY_NAME.reject do |chemical_symbol, __|
      measures.index { |measure| measure['ParameterName'] == chemical_symbol }
    end
  end

  def empty_epa_datums(chemical_to_display_name)
    chemical_to_display_name.map { |__, display_name|
      EpaDatum.new(display_name, nil, nil)
    }
  end

end
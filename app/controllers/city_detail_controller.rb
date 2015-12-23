class CityDetailController < ApplicationController
  def aqg_calculator(impl=AirQualityGradeCalculator.new)
    @aqg_calculator ||= impl
  end

  def view
    @zipcode = params["zipcode"]
    @aqi_grade = aqg_calculator.for_zipcode(@zipcode)
  end
end

class CityDetailController < ApplicationController
  def aqg_calculator(impl=AirQualityGradeCalculator.new)
    @aqg_calculator ||= impl
  end

  def view
    @zipcode = params['zipcode']
    @epa_aqg = aqg_calculator.for_zipcode(@zipcode)
    @user_aqg = params['user-aqg']
  end
end

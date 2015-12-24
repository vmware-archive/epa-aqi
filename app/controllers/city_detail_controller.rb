class CityDetailController < ApplicationController
  def aqg_calculator(impl=AirQualityGradeCalculator.new)
    @aqg_calculator ||= impl
  end

  def slot_factory(impl=SlotFactory.new)
    @slot_factory ||= impl
  end

  def view
    @zipcode = params['zipcode']
    @epa_aqg = aqg_calculator.for_zipcode(@zipcode)
    @user_aqg = params['user-aqg']
    @slots = slot_factory.for_grades(@epa_aqg, @user_aqg)
  end
end

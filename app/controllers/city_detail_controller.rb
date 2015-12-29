class CityDetailController < ApplicationController
  def slot_factory(impl=SlotFactory.new)
    @slot_factory ||= impl
  end

  def epa_data_fetcher(impl=EpaDataFetcher.new)
    @epa_data_fetcher ||= impl
  end

  def view
    @zipcode = params['zipcode']
    @city_name = ::CityForZipcode::ZIP_TO_CITY[@zipcode].try(:titleize)
    @user_aqg = AirQualityGrade.new(params['user-aqg'])

    epa_data = epa_data_fetcher.for_zipcode(@zipcode)

    @epa_aqg = epa_data.grade
    @measures = epa_data.measures
    @slots = slot_factory.for_grades(@epa_aqg, @user_aqg)
  end
end

=begin

<div class="parameter">
<div class="parameter-name">Ozone</div>
   <div class="parameter-aqi-score">38<span>Today</span></div>
   <div class="parameter-aqi-score">20<span>Average</span></div>
  </div>


=end

class EpaService
  def initialize(rest_client=RestClient)
    @rest_client = rest_client
  end

  def get_aqi_for_zipcode(zipcode)
    response = @rest_client.get(
        'http://www.airnowapi.org/aq/forecast/zipCode/',
        {
            params: {
                zipCode: zipcode,
                format: 'application/json',
                api_key: 'FF9A5E3C-BBAA-4D3D-84DC-E3590EB4E726'
            }
        }
    )
    response = JSON.parse(response)
    response[0]['AQI']
  end
end

class CityDetailController < ApplicationController
  def epa_service(impl=EpaService.new)
    @epa_service ||= impl
  end

  def view
    @zipcode = '90401'
    @epa_aqi = epa_service.get_aqi_for_zipcode(@zipcode)
  end
end

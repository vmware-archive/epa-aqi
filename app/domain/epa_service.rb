class EpaService
  AIRNOW_OBSERVATION_ENDPOINT = 'http://www.airnowapi.org/aq/observation/zipCode/current/'
  AIRNOW_API_KEY = ENV['AIRNOW_API_KEY']

  def initialize(rest_client=RestClient)
    @rest_client = rest_client
  end

  def get_measures_for_zipcode(zipcode)
    response = @rest_client.get(
        AIRNOW_OBSERVATION_ENDPOINT,
        {
            params: {
                zipCode: zipcode,
                format: 'application/json',
                api_key: AIRNOW_API_KEY
            }
        }
    )

    puts "response from EPA Forecast:\n----\n#{response}\n----" if DEBUG
    JSON.parse(response)
  end

  private
  DEBUG = false
end
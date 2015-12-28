class EpaService
  def initialize(rest_client=RestClient)
    @rest_client = rest_client
  end

  def get_measures_for_zipcode(zipcode)
    response = @rest_client.get(
        'http://www.airnowapi.org/aq/observation/zipCode/current/',
        {
            params: {
                zipCode: zipcode,
                format: 'application/json',
                api_key: 'FF9A5E3C-BBAA-4D3D-84DC-E3590EB4E726'
            }
        }
    )

    puts "response from EPA Forecast:\n----\n#{response}\n----" if DEBUG
    JSON.parse(response)
  end

  private
  DEBUG = false
end
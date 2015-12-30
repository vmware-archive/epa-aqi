require 'rest-client'

describe EpaService do
  describe '#get_aqi_for_zipcode' do
    subject(:epa_service) { EpaService.new(rest_client_mock) }
    let(:rest_client_mock) { double(RestClient) }
    let(:api_endpoint) { 'http://www.airnowapi.org/aq/observation/zipCode/current/' }
    let(:params) { { zipCode: zipcode, format: format, api_key: api_key } }
    let(:zipcode) { '90401' }
    let(:format) { 'application/json' }
    let(:api_key) { ENV['AIRNOW_API_KEY'] }
    let(:json_response) { File.read('spec/services/forecast_by_zipcode_with_valid_zipcode.response.json') }

    it 'should return the AQI for the zipcode' do
      expect(rest_client_mock).to receive(:get).with(api_endpoint, {params: params}).and_return(json_response)
      expect(epa_service.get_measures_for_zipcode(zipcode)).to eq(JSON.parse(json_response))
    end
  end
end
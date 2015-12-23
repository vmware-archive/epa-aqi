require 'rest-client'

describe EpaService do
  describe '#get_aqi_for_zipcode' do
    subject(:epa_service) { EpaService.new(rest_client_mock) }
    let(:rest_client_mock) { double(RestClient) }
    let(:api_endpoint) { 'http://www.airnowapi.org/aq/forecast/zipCode/' }
    let(:params) { { zipCode: zipcode, format: format, api_key: api_key } }
    let(:zipcode) { '90401' }
    let(:format) { 'application/json' }
    let(:api_key) { 'FF9A5E3C-BBAA-4D3D-84DC-E3590EB4E726' }
    let(:json_response) { File.read('spec/services/forecast_by_zipcode_with_valid_zipcode.response.json') }

    it 'should return the AQI for the zipcode' do
      expect(rest_client_mock).to receive(:get).with(api_endpoint, {params: params}).and_return(json_response)
      expect(epa_service.get_measures_for_zipcode(zipcode)).to eq(JSON.parse(json_response))
    end
  end
end
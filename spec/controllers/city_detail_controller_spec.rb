describe CityDetailController do
  let(:mock_epa_service) { instance_double('EpaService')}
  let(:expected_aqi) { 424 }
  before do
    allow(mock_epa_service).to receive(:get_aqi_for_zipcode).and_return(expected_aqi)
    controller.epa_service(mock_epa_service)
  end

  describe '#view' do
    it 'asks the EPA Service for the AQI value for the zipcode supplied' do
      zipcode = '90210'
      get :view, { 'zipcode' => zipcode}
      expect(mock_epa_service).to have_received(:get_aqi_for_zipcode).with(zipcode)
    end

    it 'assigns @epa_aqi to the EPA\'s AQI value for the zipcode specified' do
      get :view
      expect(assigns(:epa_aqi)).to eq(expected_aqi)
    end
  end
end

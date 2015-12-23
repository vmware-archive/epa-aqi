describe CityDetailController do
  let(:mock_aqg_calculator) { instance_double('AirQualityGradeCalculator') }
  let(:expected_epa_aqg) { 'A' }

  before do
    allow(mock_aqg_calculator).to receive(:for_zipcode).and_return(expected_epa_aqg)
    controller.aqg_calculator(mock_aqg_calculator)
  end

  describe '#view' do
    it 'asks the Air Quality Grade Calculator for the AQI grade for the zipcode supplied' do
      zipcode = '90210'
      get :view, {'zipcode' => zipcode}
      expect(mock_aqg_calculator).to have_received(:for_zipcode).with(zipcode)
    end

    it 'assigns @user_aqg to the air quality grade specified by user' do
      user_aqg = 'B'
      get :view, {'user-aqg' => user_aqg}
      expect(assigns(:user_aqg)).to eq(user_aqg)
    end

    it 'assigns @epa_aqg to the air quality grade based on EPA\'s AQI scores for the zipcode specified' do
      get :view
      expect(assigns(:epa_aqg)).to eq(expected_epa_aqg)
    end
  end
end
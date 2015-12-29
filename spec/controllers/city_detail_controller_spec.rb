describe CityDetailController do
  let(:mock_slot_factory) { instance_double('SlotFactory') }
  let(:mock_epa_data_fetcher) { instance_double('EpaDataFetcher') }
  let(:expected_slots) {
    [Slot.new(:epa_pin), Slot.new(:you_pin), Slot.new, Slot.new, Slot.new, Slot.new]
  }
  let(:expected_epa_data) {
    EpaData.new(AirQualityGrade.new('A'),
                [
                    EpaDatum.new('Ozone', 38, 20),
                    EpaDatum.new('Coarse Dust Particles (PM10)', 51, 39),
                    EpaDatum.new('Fine Particles (PM2.5)', 1, 15),
                    EpaDatum.new('Carbon Monoxide', 45, 25),
                    EpaDatum.new('Sulfur Dioxide', 45, 25),
                    EpaDatum.new('Nitrogen Dioxide', 45, 25)
                ])
  }

  before do
    allow(mock_slot_factory).to receive(:for_grades).and_return(expected_slots)
    allow(mock_epa_data_fetcher).to receive(:for_zipcode).and_return(expected_epa_data)

    controller.slot_factory(mock_slot_factory)
    controller.epa_data_fetcher(mock_epa_data_fetcher)
  end

  describe '#view' do
    it 'assigns @city_name to the city name for the zipcode supplied' do
      zipcode = '90210'
      get :view, {'zipcode' => zipcode}
      expect(assigns(:city_name)).to eq('Beverly Hills')
    end

    it 'assigns @measures to the EPA air quality measures for the zipcode supplied' do
      zipcode = '90210'

      get :view, {'zipcode' => zipcode}
      expect(assigns(:measures)).to eq(expected_epa_data.measures)
    end

    it 'assigns @user_aqg to the air quality grade specified by user' do
      user_aqg = AirQualityGrade.new('B')
      get :view, {'user-aqg' => user_aqg.grade}
      expect(assigns(:user_aqg)).to eq(user_aqg)
    end

    it 'assigns @slots to' do
      user_aqg = AirQualityGrade.new('B')
      get :view, {'user-aqg' => user_aqg.grade}
      expect(assigns(:slots)).to eq(expected_slots)
    end

    it 'assigns @epa_aqg to the AirQualityGrade for the zipcode specified' do
      get :view
      expect(assigns(:epa_aqg)).to eq(expected_epa_data.grade)
    end

    it 'assigns @epa_aqg to the air quality grade based on EPA\'s AQI scores for the zipcode specified' do
      get :view
      expect(assigns(:epa_aqg)).to eq(expected_epa_data.grade)
    end
  end
end

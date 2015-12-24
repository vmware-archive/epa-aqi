describe CityDetailController do
  let(:mock_aqg_calculator) { instance_double('AirQualityGradeCalculator') }
  let(:mock_slot_factory) { instance_double('SlotFactory') }
  let(:expected_epa_aqg) { 'A' }
  let(:expected_slots) {
    [Slot.new(:one_pin, 'EPA'), Slot.new(:one_pin, 'You'), Slot.new, Slot.new, Slot.new, Slot.new]
  }

  before do
    allow(mock_aqg_calculator).to receive(:for_zipcode).and_return(expected_epa_aqg)
    allow(mock_slot_factory).to receive(:for_grades).and_return(expected_slots)

    controller.aqg_calculator(mock_aqg_calculator)
    controller.slot_factory(mock_slot_factory)
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

    it 'assigns @slots to' do
      user_aqg = 'B'
      get :view, {'user-aqg' => user_aqg}

      expect(assigns(:slots)).to eq(expected_slots)
    end

    it 'assigns @epa_aqg to the air quality grade based on EPA\'s AQI scores for the zipcode specified' do
      get :view
      expect(assigns(:epa_aqg)).to eq(expected_epa_aqg)
    end
  end
end

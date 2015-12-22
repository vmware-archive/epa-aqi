
class FakeEpaService
  def get_aqi_for_zipcode(zipcode)
    424
  end
end

describe CityDetailController do
  before { controller.epa_service(FakeEpaService.new) }

  describe '#view' do
    it 'assigns @epa_aqi to the EPA\'s AQI value for the zipcode specified' do

      get :view
      expect(assigns(:epa_aqi)).to eq(424)
    end
  end
end

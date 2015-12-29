describe EpaDataFetcher do
  let(:mock_epa_service) { instance_double('EpaService') }
  let(:mock_aqg_calculator) { instance_double('AirQualityGradeCalculator') }
  let(:zipcode) { '90210' }

  let(:measures_from_epa_service) {
    JSON.parse('[' +
                   generate_measure_json_of_category(1, 1, 'Good', 'O3') + ', ' +
                   generate_measure_json_of_category(1, 1, 'Good', 'PM2.5') + ', ' +
                   generate_measure_json_of_category(1, 1, 'Good', 'PM10') + ', ' +
                   generate_measure_json_of_category(1, 1, 'Good', 'CO') + ', ' +
                   generate_measure_json_of_category(1, 1, 'Good', 'SO2') + ', ' +
                   generate_measure_json_of_category(1, 1, 'Good', 'NO2') +
                   ']')
  }

  let(:expected_epa_datums) {
    [
        EpaDatum.new('Ozone', 1, nil),
        EpaDatum.new('Fine Particles (PM2.5)', 1, nil),
        EpaDatum.new('Coarse Dust Particles (PM10)', 1, nil),
        EpaDatum.new('Carbon Monoxide', 1, nil),
        EpaDatum.new('Sulfur Dioxide', 1, nil),
        EpaDatum.new('Nitrogen Dioxide', 1, nil)
    ]
  }

  let(:epa_aqg) { AirQualityGrade.new('A') }
  let(:expected_epa_data) { EpaData.new(epa_aqg, expected_epa_datums) }

  subject do
    epa_data_fetcher = EpaDataFetcher.new
    epa_data_fetcher.epa_service(mock_epa_service)
    epa_data_fetcher.aqg_calculator(mock_aqg_calculator)
    epa_data_fetcher.for_zipcode(zipcode)
  end

  before do
    allow(mock_epa_service).to receive(:get_measures_for_zipcode).and_return(measures_from_epa_service)
    allow(mock_aqg_calculator).to receive(:grade_for).and_return(epa_aqg)
  end

  describe '#for_zipcode' do
    it 'asks the EPA Service for the measures for the zip code supplied' do
      subject
      expect(mock_epa_service).to have_received(:get_measures_for_zipcode).with(zipcode)
    end

    it 'asks AirQualityGradeCalculator to grade the air quality' do
      subject
      expect(mock_aqg_calculator).to have_received(:grade_for).with(measures_from_epa_service)
    end

    it 'returns the EPA Data: the air quality grade and details' do
      expect(subject).to eq(expected_epa_data)
    end

    describe 'when there are pollutants with measures and pollutants without' do
      let(:measures_from_epa_service) {
        JSON.parse('[' +
                       generate_measure_json_of_category(1, 1, 'Good', 'O3') + ', ' +
                       generate_measure_json_of_category(1, 1, 'Good', 'NO2') +
                       ']')
      }
      let(:expected_epa_datums) {
        [
            EpaDatum.new('Ozone', 1, nil),
            EpaDatum.new('Nitrogen Dioxide', 1, nil),
            EpaDatum.new('Fine Particles (PM2.5)', nil, nil),
            EpaDatum.new('Coarse Dust Particles (PM10)', nil, nil),
            EpaDatum.new('Carbon Monoxide', nil, nil),
            EpaDatum.new('Sulfur Dioxide', nil, nil)
        ]
      }
      it 'should present pollutants with measures before those without' do
        expect(subject).to eq(expected_epa_data)
      end
    end

    describe 'when there are no measures' do
      let(:measures_from_epa_service) { [] }
      let(:expected_epa_datums) {
        [
            EpaDatum.new('Ozone', nil, nil),
            EpaDatum.new('Fine Particles (PM2.5)', nil, nil),
            EpaDatum.new('Coarse Dust Particles (PM10)', nil, nil),
            EpaDatum.new('Carbon Monoxide', nil, nil),
            EpaDatum.new('Sulfur Dioxide', nil, nil),
            EpaDatum.new('Nitrogen Dioxide', nil, nil)
        ]
      }
      it 'returns a list of "empty" datum' do
        expect(subject).to eq(expected_epa_data)
      end
    end

    describe 'when there are pollutants that are not top EPA pollutants' do
      let(:measures_from_epa_service) {
        JSON.parse('[' +
                       generate_measure_json_of_category(1, 1, 'Good', 'H3Si9')  +
                       ']')
      }
      let(:expected_epa_datums) {
        [
            EpaDatum.new('Ozone', nil, nil),
            EpaDatum.new('Fine Particles (PM2.5)', nil, nil),
            EpaDatum.new('Coarse Dust Particles (PM10)', nil, nil),
            EpaDatum.new('Carbon Monoxide', nil, nil),
            EpaDatum.new('Sulfur Dioxide', nil, nil),
            EpaDatum.new('Nitrogen Dioxide', nil, nil)
        ]
      }
      it 'should return only the top EPA pollutants' do
        expect(subject).to eq(expected_epa_data)
      end
    end
  end
end
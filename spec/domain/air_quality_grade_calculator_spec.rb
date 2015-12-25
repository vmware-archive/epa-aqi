describe AirQualityGradeCalculator do
  let(:mock_epa_service) { instance_double('EpaService') }
  let(:expected_measures) { generate_measures_of_category(1, 1, 'Good') }
  let(:zipcode) { '90210' }

  subject do
    aqg_calculator = AirQualityGradeCalculator.new
    aqg_calculator.epa_service(mock_epa_service)
    aqg_calculator.for_zipcode(zipcode)
  end

  before do
    allow(mock_epa_service).to receive(:get_measures_for_zipcode).and_return(expected_measures)
  end

  describe '#for_zipcode' do
    let(:least_healthy_measure) { generate_measure_of_category(1, 1, 'Good') }
    let(:expected_measures) { generate_measures_of_category(1, 1, 'Good') }

    it 'asks the EPA Service for the AQI value for the zipcode supplied' do
      subject
      expect(mock_epa_service).to have_received(:get_measures_for_zipcode).with(zipcode)
    end

    specify { expect(subject).to eq AirQualityGrade.new(least_healthy_measure) }

    describe 'when the least healthy measure is not the first' do
      let(:least_healthy_measure) { generate_measure_of_category(301, 6, 'Hazardous') }
      let(:expected_measures) {
        JSON.parse('[' +
                       generate_measure_json_of_category(1, 1, 'Good') + ', ' +
                       generate_measure_json_of_category(301, 6, 'Hazardous') +
                       ']');
      }
      specify { expect(subject).to eq AirQualityGrade.new(least_healthy_measure) }
    end
  end
end
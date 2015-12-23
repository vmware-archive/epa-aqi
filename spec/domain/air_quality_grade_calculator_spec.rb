def generate_measure_of_category(aqi_score, number, name)
  "{
    \"AQI\": #{aqi_score},
    \"Category\": {
      \"Number\": #{number},
      \"Name\": \"#{name}\"
    }
  }"
end

def generate_measures_of_category(aqi_score, number, name)
  JSON.parse('[' + generate_measure_of_category(aqi_score, number, name)+']')
end

describe AirQualityGradeCalculator do
  let(:mock_epa_service) { instance_double('EpaService') }
  let(:mock_aqi_grader) { instance_double('AqiGrader') }
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
    it 'asks the EPA Service for the AQI value for the zipcode supplied' do
      subject
      expect(mock_epa_service).to have_received(:get_measures_for_zipcode).with(zipcode)
    end

    describe 'the least healthy measure is a category 1 ("Good")' do
      let(:expected_measures) { generate_measures_of_category(1, 1, 'Good') }
      specify { expect(subject).to eq 'A' }
    end

    describe 'the least healthy measure is a category 2 ("Moderate")' do
      let(:expected_measures) { generate_measures_of_category(51, 2, 'Moderate') }
      specify { expect(subject).to eq 'B' }
    end

    describe 'the least healthy measure is a category 3 ("Unhealthy for Sensitive")' do
      let(:expected_measures) { generate_measures_of_category(101, 3, 'Unhealthy for Sensitive') }
      specify { expect(subject).to eq 'C' }
    end

    describe 'the least healthy measure is a category 4 ("Unhealthy")' do
      let(:expected_measures) { generate_measures_of_category(151, 4, 'Unhealthy') }
      specify { expect(subject).to eq 'D' }
    end

    describe 'the least healthy measure is a category 5 ("Very Unhealthy")' do
      let(:expected_measures) { generate_measures_of_category(201, 5, 'Very Unhealthy') }
      specify { expect(subject).to eq 'E' }
    end

    describe 'the least healthy measure is a category 6 ("Hazardous")' do
      let(:expected_measures) { generate_measures_of_category(301, 6, 'Hazardous') }
      specify { expect(subject).to eq 'F' }
    end

    describe 'when the least healthy measure is not the first' do
      let(:expected_measures) {
        JSON.parse('[' +
                       generate_measure_of_category(1, 1, 'Good') + ', ' +
                       generate_measure_of_category(301, 6, 'Hazardous') +
                   ']');
      }
      specify { expect(subject).to eq 'F'}
    end
  end
end
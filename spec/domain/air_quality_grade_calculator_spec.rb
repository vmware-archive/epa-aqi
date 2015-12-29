describe AirQualityGradeCalculator do
  subject do
    aqg_calculator = AirQualityGradeCalculator.new
    aqg_calculator.grade_for(measures)
  end

  describe '#grade_for' do
    let(:least_healthy_measure) { generate_measure_of_category(1, 1, 'Good') }
    let(:measures) { generate_measures_of_category(1, 1, 'Good') }

    specify { expect(subject).to eq AirQualityGrade.new(least_healthy_measure) }

    describe 'when the least healthy measure is not the first' do
      let(:least_healthy_measure) { generate_measure_of_category(301, 6, 'Hazardous') }
      let(:measures) {
        JSON.parse('[' +
                       generate_measure_json_of_category(1, 1, 'Good') + ', ' +
                       generate_measure_json_of_category(301, 6, 'Hazardous') +
                       ']');
      }
      specify { expect(subject).to eq AirQualityGrade.new(least_healthy_measure) }
    end
  end
end
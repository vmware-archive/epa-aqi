describe AirQualityGrade do
  describe 'when initialized with a measure' do
    let(:measure) { generate_measure_of_category(25, 1, 'Good') }

    subject { AirQualityGrade.new(measure) }
    describe '#aqi' do
      it 'matches the AQI from the measure' do
        expect(subject.aqi).to eq(25)
      end
    end

    describe '#grade' do
      describe 'the measure is a category 1 ("Good")' do
        let(:measure) { generate_measure_of_category(1, 1, 'Good') }
        specify { expect(subject.grade).to eq 'A' }
      end

      describe 'the measure is a category 2 ("Moderate")' do
        let(:measure) { generate_measure_of_category(51, 2, 'Moderate') }
        specify { expect(subject.grade).to eq 'B' }
      end

      describe 'the measure is a category 3 ("Unhealthy for Sensitive")' do
        let(:measure) { generate_measure_of_category(101, 3, 'Unhealthy for Sensitive') }
        specify { expect(subject.grade).to eq 'C' }
      end

      describe 'the measure is a category 4 ("Unhealthy")' do
        let(:measure) { generate_measure_of_category(151, 4, 'Unhealthy') }
        specify { expect(subject.grade).to eq 'D' }
      end

      describe 'the measure is a category 5 ("Very Unhealthy")' do
        let(:measure) { generate_measure_of_category(201, 5, 'Very Unhealthy') }
        specify { expect(subject.grade).to eq 'E' }
      end

      describe 'the measure is a category 6 ("Hazardous")' do
        let(:measure) { generate_measure_of_category(301, 6, 'Hazardous') }
        specify { expect(subject.grade).to eq 'F' }
      end
    end
  end

  describe 'when initialized with a grade' do
    subject { AirQualityGrade.new('A') }
     describe '#aqi' do
       it 'returns nil' do
         expect(subject.aqi).to be_nil
       end
     end
    describe '#grade' do
      it 'returns the specified grade' do
        expect(subject.grade).to eq('A')
      end
    end
  end
end
describe ApplicationHelper do
  describe '#slot_type_to_css_class' do
    subject { helper.slot_type_to_css_class(slot_type) }

    describe 'when slot.type is :you_pin' do
      let(:slot_type) { :you_pin }
      it 'returns "you-pin"' do
        expect(subject).to eq('you-pin')
      end
    end
    describe 'when slot.type is :epa_pin' do
      let(:slot_type) { :epa_pin }
      it 'returns "epa-pin"' do
        expect(subject).to eq('epa-pin')
      end
    end
    describe 'when slot.type is :match_pin' do
      let(:slot_type) { :match_pin }
      it 'returns "match-pin"' do
        expect(subject).to eq('match-pin')
      end
    end
    describe 'when slot.type is :empty' do
      let(:slot_type) { :empty }
      it 'returns "empty-slot"' do
        expect(subject).to eq('empty-slot')
      end
    end
    describe 'when slot is nil' do
      let(:slot_type) { nil }
      it 'returns "empty-slot"' do
          expect(subject).to eq('empty-slot')
      end
    end
  end
  describe '#grade_to_css_class' do
    subject { helper.grade_to_css_class(grade) }

    describe 'when grade is A' do
      let(:grade) { AirQualityGrade.new('A') }
      specify { expect(subject).to eq('grade-a') }
    end

    describe 'when grade is B' do
      let(:grade) { AirQualityGrade.new('B') }
      specify { expect(subject).to eq('grade-b') }
    end

    describe 'when grade is C' do
      let(:grade) { AirQualityGrade.new('C') }
      specify { expect(subject).to eq('grade-c') }
    end

    describe 'when grade is D' do
      let(:grade) { AirQualityGrade.new('D') }
      specify { expect(subject).to eq('grade-d') }
    end

    describe 'when grade is E' do
      let(:grade) { AirQualityGrade.new('E') }
      specify { expect(subject).to eq('grade-e') }
    end

    describe 'when grade is F' do
      let(:grade) { AirQualityGrade.new('F') }
      specify { expect(subject).to eq('grade-f') }
    end
  end
end

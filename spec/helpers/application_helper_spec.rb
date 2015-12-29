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
end

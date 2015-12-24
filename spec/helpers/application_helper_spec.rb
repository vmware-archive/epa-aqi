describe ApplicationHelper do
  describe '#slot_type_to_css_class' do
    subject { helper.slot_type_to_css_class(slot_type) }

    describe 'when slot.type is :one_pin' do
      let(:slot_type) { :one_pin }
      it 'returns "single-pin"' do
        expect(subject).to eq('single-pin')
      end
    end
    describe 'when slot.type is :two_pin' do
      let(:slot_type) { :two_pin }
      it 'returns "multiple-pins"' do
        expect(subject).to eq('multiple-pins')
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

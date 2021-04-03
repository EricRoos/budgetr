RSpec.shared_examples 'edit_lockable' do
  describe '#locked_for_edit?' do
    let(:obj) { described_class.new }
    subject { obj.locked_for_edit? }
    it { is_expected.to be false }

    context 'when an edit_lock exists' do
      before do
        allow(obj).to receive(:edit_lock).and_return(EditLock.new(lockable: obj))
      end
      it { is_expected.to be true }
    end
  end
end

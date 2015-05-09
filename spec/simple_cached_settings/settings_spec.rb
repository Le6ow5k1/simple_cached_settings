require 'spec_helper'

describe MySettings do
  describe '.write' do
    context 'when row with this key does not exist' do
      it 'creates new instance of Settings model' do
        expect { described_class.write(:god_mode, true) }.to change { described_class.count }.by(1)
      end

      it 'saves instance with right key and value fields' do
        described_class.write(:god_mode, true)
        setting = described_class.find_by(key: :god_mode)

        expect(setting.key).to eq('god_mode')
        expect(setting.value).to be true
      end
    end

    context 'when row with this key exist' do
      before do
        @setting = described_class.create(key: :password, value: 'qwerty')
      end

      it 'does not create new instance of Settings model' do
        expect { described_class.write(@setting.key, '123') }.to_not change { described_class.count }
      end

      it 'updates value of existing Settings model' do
        described_class.write(@setting.key, '1')
        expect(@setting.reload.value).to eq('1')
      end
    end
  end

  describe '.read' do
    context 'when there is a setting with such key' do
      before do
        @setting = described_class.create(key: :number, value: 10)
      end

      it 'returns value of that setting' do
        expect(described_class.read(@setting.key)).to eq(@setting.value)
      end
    end

    context 'when there is no setting with such key' do
      it 'returns nil' do
        expect(described_class.read(:non_existing_key)).to be nil
      end
    end
  end
end

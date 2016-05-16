require 'spec_helper'

describe Hash do
  let(:symbolized_hash) do
    {
      key1: {
        key1_key1: 'value'
      },
      key2: 'value2'
    }
  end

  subject do
    {
      'key1': {
        'key1_key1': 'value'
      },
      'key2': 'value2'
    }
  end

  describe 'symbolize_keys_deep!' do
    it 'returns symbolized hash' do
      expect(subject.symbolize_keys_deep!).to eq symbolized_hash
    end

    it 'convert keys to symbol type' do
      subject.symbolize_keys_deep!
      expect(subject).to eq symbolized_hash
    end
  end
end

require 'spec_helper'

describe Nuvi::Model::Zipfile do
  let(:accepted_url) { 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1463122532318.zip' }
  let(:url) { 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1463122921006.zip' }
  let(:set) { Redis::Set.new('accepted_zipfiles') }

  before { set << accepted_url }

  describe 'self#include?' do
    it 'returns true for already saved' do
      expect(described_class.include?(accepted_url)).to be_truthy
    end

    it 'returns false for not saved' do
      expect(described_class.include?(url)).to be_falsey
    end
  end

  describe 'self#save!' do
    it 'saves url of accepted zipfile in set' do
      expect { described_class.save!(url) }.to change(set, :size).by(1)
    end

    it 'returns true if saved' do
      expect(described_class.save!(url)).to be_truthy
    end

    it 'not changes set for already accepted zipfile' do
      expect { described_class.save!(accepted_url) }.to_not change(set, :size)
    end

    it 'returns false if not saved' do
      expect(described_class.save!(accepted_url)).to be_falsey
    end
  end
end

require 'spec_helper'

describe Nuvi::Hasher do
  describe 'self#hash' do
    it 'returns sha256 hash' do
      expect(described_class.hash('some message')).to eq 'c47757abe4020b9168d0776f6c91617f9290e790ac2f6ce2bd6787c74ad88199'
    end
  end
end

require 'spec_helper'

describe Nuvi::Model::News do
  let(:accepted_content) { 'accepted content' }
  let(:content) { 'new content' }
  let(:set) { Redis::Set.new('accepted_news') }
  let(:list) { Redis::List.new('NEWS_XML') }

  before { set << Nuvi::Hasher.hash(accepted_content) }

  describe 'self#include?' do
    it 'returns true for already saved' do
      expect(described_class.include?(Nuvi::Hasher.hash(accepted_content))).to be_truthy
    end

    it 'returns false for not saved' do
      expect(described_class.include?(Nuvi::Hasher.hash(content))).to be_falsey
    end
  end

  describe 'self#save!' do
    it 'saves new content in list' do
      expect { described_class.save!(content) }.to change(list, :size).by(1)
    end

    it 'saves hash of new content in set' do
      expect { described_class.save!(content) }.to change(set, :size).by(1)
    end

    it 'returns true if saved' do
      expect(described_class.save!(content)).to be_truthy
    end

    it 'not changes set for already saved content' do
      expect { described_class.save!(accepted_content) }.to_not change(set, :size)
    end

    it 'not changes list for already saved content' do
      expect { described_class.save!(accepted_content) }.to_not change(list, :size)
    end

    it 'returns false if not saved' do
      expect(described_class.save!(accepted_content)).to be_falsey
    end
  end
end

require 'spec_helper'

describe Nuvi::Grabber do
  subject { described_class.new(url, dir) }
  let(:url) { 'http://bitly.com/nuvi-plz' }
  let(:dir) { "#{Dir.tmpdir}/nuvi/" }

  describe '#initialize' do
    it 'assigns @url' do
      expect(subject.instance_variable_get(:'@url')).to eq(url)
    end

    it 'assigns @dir' do
      expect(subject.instance_variable_get(:'@dir')).to eq(dir)
    end
  end

  describe '#perform' do
    it 'calls PageParser#get_file_url_list' do
      allow(Nuvi::PageParser).to receive(:get_file_url_list).with(url)
    end

    it 'calls worker' do
      allow(Workers::Pool).to receive(:enqueue)
    end
  end
end

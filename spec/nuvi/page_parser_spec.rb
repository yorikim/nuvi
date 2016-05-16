require 'spec_helper'

describe Nuvi::PageParser do
  let(:accepted_zip) { 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1463047291866.zip' }
  let(:set) { Redis::Set.new('accepted_zipfiles') }
  before { set << accepted_zip }

  describe 'self#get_file_url_list' do
    let(:url_list) do
      VCR.use_cassette('main_page') { described_class.get_file_url_list('http://bitly.com/nuvi-plz') }
    end

    it 'returns url_list' do
      expect(url_list.size).to eq(861 - set.size)
    end

    it 'contains filename and url' do
      expect(url_list['1463046785377.zip']).to eq('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1463046785377.zip')
    end

    it 'ignore already processed zip files' do
      expect(url_list['1463047291866.zip']).to be_nil
    end
  end
end

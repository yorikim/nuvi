require 'spec_helper'

describe Nuvi::Grabber do
  subject { described_class.new(url, dir) }
  let(:url) { 'http://bitly.com/nuvi-plz' }
  let(:dir) { "#{Dir.tmpdir}/nuvi/" }
  let(:zip_urls) do
    { '1463046785377.zip': 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/1463046785377.zip' }
  end
  let(:page_parser) do
    page_parser = double('PageParser')
    allow(page_parser).to receive(:get_file_url_list)
    page_parser
  end
  let(:progress_bar) do
    progress_bar = double('ProgressBar')
    allow(progress_bar).to receive(:create)
    progress_bar
  end
  let(:pool) do
    pool = double('WorkerPool')
    allow(pool).to receive(:enqueue)
    allow(pool).to receive(:dispose)
    pool
  end

  describe '#initialize' do
    it 'assigns @url' do
      expect(subject.instance_variable_get(:'@url')).to eq(url)
    end

    it 'assigns @dir' do
      expect(subject.instance_variable_get(:'@dir')).to eq(dir)
    end
  end

  describe '#perform' do
    before do
      allow(Nuvi::PageParser).to receive(:get_file_url_list).with(url).and_return(zip_urls)
      allow(Workers::Pool).to receive(:new).and_return(pool)
      allow(ProgressBar).to receive(:create).and_return(progress_bar)
    end

    it 'calls PageParser#get_file_url_list' do
      expect(Nuvi::PageParser).to receive(:get_file_url_list).with(url)
      subject.perform
    end

    it 'calls pool#perform' do
      file, url = zip_urls.first
      dir_path = "#{dir}/#{file}"

      expect(pool).to receive(:enqueue).with(:perform, url: url, dir_path: dir_path, progress_bar: progress_bar)
      subject.perform
    end

    it 'disposees the pool' do
      expect(pool).to receive(:dispose)
      subject.perform
    end
  end
end

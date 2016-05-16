require 'spec_helper'

describe Nuvi::Worker::ZipfileWorker do
  let(:url) { "file://#{Dir.pwd}/spec/support/fixtures/zip/#{filename}" }
  let(:filename) { '1463127537956.zip' }
  let(:dir_path) { "#{Dir.tmpdir}/nuvi/" }
  let(:progress_bar) { ProgressBar.create total: 1, output: MockOutput.new }
  let(:event) { Workers::Event.new(:perform, url: url, dir_path: dir_path, progress_bar: progress_bar) }
  let(:xml_set) { Redis::Set.new('accepted_news') }

  before do
    progress_bar.refresh
    xml_set << 'db9c5f8612f94ac59f7850bebd711dcc480d112f60dad5329010c033b23a99d3'
    FileUtils.rm_rf("#{dir_path}/.", secure: true)
  end

  describe '#event_handler' do
    context 'process zip file' do
      before { subject.send :event_handler, event }
      it 'downloads zip file and extracts xml files' do
        zip_files = Dir["#{dir_path}/*.zip"]
        expect(zip_files.size).to eq 1
      end

      it 'extracts xml files' do
        xml_files = Dir["#{dir_path}/*.xml"]
        expect(xml_files.size).to eq 3
      end

      it 'save processed and ignore old xml files in list' do
        expect(Redis::List.new('NEWS_XML').size).to eq(2)
      end

      it 'save processed hash of xml files in set' do
        expect(Redis::Set.new('accepted_news').size).to eq(3)
      end

      it 'save processed zip file' do
        expect(Redis::Set.new('accepted_zipfiles').size).to eq(1)
      end
    end

    context 'stubs' do
      it 'class progress_bar#increment' do
        expect(progress_bar).to receive(:increment)
        subject.send :event_handler, event
      end
    end
  end
end

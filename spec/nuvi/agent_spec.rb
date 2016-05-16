require 'spec_helper'

describe Nuvi::Agent do
  describe 'self#run!' do
    let(:grabber) do
      grabber = double('NuviGrabber')
      allow(grabber).to receive(:new)
      allow(grabber).to receive(:perform)
      grabber
    end

    before do
      allow(Nuvi::Grabber).to receive(:new).and_return(grabber)
    end

    it 'init grabber' do
      expect(Nuvi::Grabber).to receive(:new).with('http://bitly.com/nuvi-plz', '/tmp/nuvi/')
      described_class.run!
    end

    it 'runs grabber' do
      expect(grabber).to receive(:perform)
      described_class.run!
    end
  end
end

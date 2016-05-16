require 'spec_helper'

describe Nuvi::Agent do
  describe 'self#run!' do
    it 'runs grabber' do
      allow(Nuvi::Grabber).to receive(:new).with('http://bitly.com/nuvi-plz', '/tmp/nuvi/')
    end
  end
end

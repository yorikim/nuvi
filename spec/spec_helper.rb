$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nuvi'
require 'vcr'
require 'webmock/rspec'
require 'fakeredis/rspec'
require 'redis-objects'

Redis::Objects.redis = Redis.new

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
Dir["#{root}/spec/support/**/*.rb"].each { |f| require f }

require 'connection_pool'
require 'redis-objects'
require 'optparse'
require 'yaml'

module Nuvi
  class Agent
    class << self
      def run!
        options = parse_options
        init_redis(options[:redis])

        Nuvi::Grabber.new(options[:url], options[:dir]).perform
      end

      private

      def parse_options
        options = default_options

        OptionParser.new do |opts|
          opts.banner = 'Usage: nuvi_grabber [options]'

          opts.on('-c', '--config PATH_TO_CONFIG', String, 'Path to your config file') do |path|
            options = YAML.load_file(path).symbolize_keys_deep!
          end

          opts.on_tail('-h', '--help', 'Show this message') do
            puts opts
            exit
          end
        end.parse!

        options
      end

      def init_redis(options)
        Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(options) }
      end

      def default_options
        {
          url: 'http://bitly.com/nuvi-plz',
          dir: '/tmp/nuvi/',
          redis: {
            host: '127.0.0.1',
            port: 6379,
            password: nil
          }
        }
      end
    end
  end
end

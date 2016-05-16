require 'digest'

module Nuvi
  class Hasher
    class << self
      def hash(content, digest = Digest::SHA256)
        digest.hexdigest(content)
      end
    end
  end
end

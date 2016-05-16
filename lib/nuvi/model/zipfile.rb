module Nuvi
  module Model
    class Zipfile
      class << self
        def include?(url)
          accepted.member? url
        end

        def save!(url)
          return false if include?(url)
          accepted << url
          true
        end

        private

        def accepted
          @accepted ||= Redis::Set.new('accepted_zipfiles')
        end
      end
    end
  end
end

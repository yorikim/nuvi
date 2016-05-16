module Nuvi
  module Model
    class News
      class << self
        def include?(hash)
          accepted.member? hash
        end

        def save!(content)
          hash = Hasher.hash(content)
          return false if include?(hash)

          Redis.current.multi do
            list << content
            accepted << hash
          end

          true
        end

        private

        def list
          @list ||= Redis::List.new('NEWS_XML')
        end

        def accepted
          @accepted ||= Redis::Set.new('accepted_news')
        end
      end
    end
  end
end

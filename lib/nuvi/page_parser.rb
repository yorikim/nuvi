require 'nokogiri'
require 'open-uri'

module Nuvi
  class PageParser
    class << self
      SELECTOR = 'table tr:nth-child(n+4) a'.freeze

      def get_file_url_list(page_url)
        open(page_url) do |response|
          doc = Nokogiri::HTML(response)
          url_list = doc.css(SELECTOR).map { |a| a['href'] }
          return Hash[filtered_list(response.base_uri.to_s, url_list).map { |url| [url, response.base_uri.to_s + url] }]
        end
      end

      private

      def filtered_list(base_uri, url_list)
        url_list.select { |url| !Model::Zipfile.include?(base_uri + url) }
      end
    end
  end
end

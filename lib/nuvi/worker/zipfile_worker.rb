require 'workers'

module Nuvi
  module Worker
    class ZipfileWorker < Workers::Worker
      private

      def event_handler(event)
        return super(event) if event.command != :perform

        process_zipfile(event.data[:url], event.data[:dir_path])
        event.data[:progress_bar].increment
      end

      def process_zipfile(url, dir_path)
        FileUtils.rm_rf("#{dir_path}/.", secure: true)
        download_and_extract(url, dir_path)
        save_news(dir_path)
        Model::Zipfile.save!(url)
      end

      def download_and_extract(url, dir_path)
        downloader = Pod::Downloader.for_target(dir_path, http: url)
        downloader.download
      end

      def save_news(dir_path)
        Dir["#{dir_path}/**/*.xml"].each { |file| Model::News.save!(File.read(file)) }
      end
    end
  end
end

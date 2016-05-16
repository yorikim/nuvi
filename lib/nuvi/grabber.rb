require 'ruby-progressbar'

module Nuvi
  class Grabber
    def initialize(url, dir)
      @url = url
      @dir = dir
    end

    def perform
      url_list.each do |filename, url|
        pool.enqueue(:perform, url: url, dir_path: "#{@dir}/#{filename}", progress_bar: progress_bar)
      end
      pool.dispose
    end

    private

    def progress_bar
      @progress_bar ||= ProgressBar.create(title: 'Progress', total: url_list.size)
    end

    def url_list
      @url_list ||= PageParser.get_file_url_list(@url)
    end

    def pool
      @pool ||= Workers::Pool.new(worker_class: Worker::ZipfileWorker, on_exception: proc do |e|
        puts "A zipfile worker threw exception: #{e.class}: #{e.message}"
      end)
    end
  end
end

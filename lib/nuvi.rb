module Nuvi
  require 'nuvi/core_ext/hash/symbolize_keys_deep'

  require 'nuvi/model/news'
  require 'nuvi/model/zipfile'
  require 'nuvi/worker/zipfile_worker'

  require 'nuvi/hasher'
  require 'nuvi/page_parser'
  require 'nuvi/grabber'
  require 'nuvi/agent'
  require 'nuvi/version'
  require 'pod/downloader/base'
end

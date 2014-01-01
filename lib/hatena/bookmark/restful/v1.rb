require 'faraday'
require 'json'

module Hatena
  module Bookmark
    module Restful; end
  end
end

class Hatena::Bookmark::Restful::V1
  def my
    res = connection.get('/1/my')
    JSON.parse(res.body)
  end

  def my_tags
    res = connection.get('/1/my/tags')
    JSON.parse(res.body)
  end

  def entry(url)
    res = connection.get('/1/entry', url: url)
    JSON.parse(res.body)
  end

  def bookmark(url)
    res = connection.get('/1/my/bookmark', url: url)
    JSON.parse(res.body)
  end

  def delete_bookmark(url)
    res = connection.delete('/1/my/bookmark', url: url)
    res.success?
  end

  def create_bookmark(bookmark_params)
    res = connection.post('/1/my/bookmark', bookmark_params)
    JSON.parse(res.body)
  end

  private

  def connection
    @connection ||= Faraday.new() do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end

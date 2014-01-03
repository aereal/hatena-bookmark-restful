require 'faraday'
require 'faraday_middleware'
require 'json'

module Hatena
  module Bookmark
    module Restful; end
  end
end

class Hatena::Bookmark::Restful::V1
  BASE_URI = 'http://api.b.hatena.ne.jp'
  API_VERSION = '1'

  def initialize(credentials = {})
    @consumer_key        = credentials.fetch(:consumer_key)
    @consumer_secret     = credentials.fetch(:consumer_secret)
    @access_token        = credentials.fetch(:access_token)
    @access_token_secret = credentials.fetch(:access_token_secret)
  end

  def my
    res = connection.get("/#{api_version}/my")
    JSON.parse(res.body)
  end

  def my_tags
    res = connection.get("/#{api_version}/my/tags")
    JSON.parse(res.body)
  end

  def entry(url)
    res = connection.get("/#{api_version}/entry", url: url)
    JSON.parse(res.body)
  end

  def bookmark(url)
    res = connection.get("/#{api_version}/my/bookmark", url: url)
    JSON.parse(res.body)
  end

  def delete_bookmark(url)
    res = connection.delete("/#{api_version}/my/bookmark", url: url)
    res.success?
  end

  def create_bookmark(bookmark_params)
    res = connection.post("/#{api_version}/my/bookmark", bookmark_params)
    JSON.parse(res.body)
  end

  def api_version
    API_VERSION
  end

  def base_uri
    BASE_URI
  end

  private

  def connection
    @connection ||= Faraday.new(url: base_uri) do |faraday|
      faraday.request :url_encoded
      faraday.request :oauth,
        consumer_key:    @consumer_key,
        consumer_secret: @consumer_secret,
        token:           @access_token,
        token_secret:    @access_token_secret
      faraday.adapter Faraday.default_adapter
    end
  end
end

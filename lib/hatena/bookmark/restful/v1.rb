require 'faraday'
require 'faraday_middleware'
require 'json'
require 'hatena/bookmark/restful/v1/user'
require 'hatena/bookmark/restful/v1/tag'
require 'hatena/bookmark/restful/v1/entry'
require 'hatena/bookmark/restful/v1/bookmark'

module Hatena
  module Bookmark
    module Restful; end
  end
end

class Hatena::Bookmark::Restful::V1
  BASE_URI = 'http://api.b.hatena.ne.jp'
  API_VERSION = '1'

  class Credentials
    # @!attribute [rw] consumer_key
    #   @return [String]
    # @!attribute [rw] consumer_secret
    #   @return [String]
    # @!attribute [rw] access_token
    #   @return [String]
    # @!attribute [rw] access_token_secret
    #   @return [String]
    attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

    # @param [Hash] attributes
    # @option attributes [String] :consumer_key
    # @option attributes [String] :consumer_secret
    # @option attributes [String] :access_token
    # @option attributes [String] :access_token_secret
    def initialize(attributes)
      @consumer_key        = attributes.fetch(:consumer_key)
      @consumer_secret     = attributes.fetch(:consumer_secret)
      @access_token        = attributes.fetch(:access_token)
      @access_token_secret = attributes.fetch(:access_token_secret)
    end
  end

  def initialize(credentials)
    @credentials = credentials
  end

  # @return [User]
  def my
    res = connection.get("/#{api_version}/my")
    attrs = JSON.parse(res.body)
    user = User.new_from_response(attrs)
  end

  # @return [<Tag>]
  def my_tags
    res = connection.get("/#{api_version}/my/tags")
    attrs = JSON.parse(res.body)
    raw_tags = attrs.fetch('tags')
    tags = raw_tags.map {|t| Tag.new_from_response(t) }
  end

  # @return [Entry]
  def entry(url)
    res = connection.get("/#{api_version}/entry", url: url)
    attrs = JSON.parse(res.body)
    entry = Entry.new_from_response(attrs)
  end

  # @return [Bookmark]
  def bookmark(url)
    res = connection.get("/#{api_version}/my/bookmark", url: url)
    attrs = JSON.parse(res.body)
    bookmark = Bookmark.new_from_response(attrs)
  end

  # @return [Boolean]
  def delete_bookmark(url)
    res = connection.delete("/#{api_version}/my/bookmark", url: url)
    res.success?
  end

  # @return [Bookmark]
  def create_bookmark(bookmark_params)
    res = connection.post("/#{api_version}/my/bookmark", bookmark_params)
    attrs = JSON.parse(res.body)
    bookmark = Bookmark.new_from_response(attrs)
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
      faraday.options.params_encoder = Faraday::FlatParamsEncoder
      faraday.request :oauth,
        consumer_key:    @credentials.consumer_key,
        consumer_secret: @credentials.consumer_secret,
        token:           @credentials.access_token,
        token_secret:    @credentials.access_token_secret
      faraday.headers["User-Agent"] = "hatena-bookmark-restful"
      faraday.adapter Faraday.default_adapter
    end
  end
end

require "hatena/bookmark/restful/v1/response_object"

module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

class Hatena::Bookmark::Restful::V1::Entry
  # @!attribute [r] title
  #   @return [String]
  # @!attribute [r] url
  #   @return [String]
  # @!attribute [r] entry_url
  #   @return [String]
  # @!attribute [r] count
  #   @return [Integer]
  # @!attribute [r] favicon_url
  #   @return [String]
  # @!attribute [r] smartphone_app_entry_url
  #   @return [String]
  PROPERTIES = [:title, :url, :entry_url, :count, :favicon_url, :smartphone_app_entry_url]

  include Hatena::Bookmark::Restful::V1::ResponseObject
end

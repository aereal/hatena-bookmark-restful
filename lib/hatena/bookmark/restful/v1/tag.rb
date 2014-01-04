require "hatena/bookmark/restful/v1/response_object"

module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

class Hatena::Bookmark::Restful::V1::Tag
  # @!attribute [r] tag
  #   The name of tag
  #   @return [String]
  # @!attribute [r] count
  #   The number of bookmarks with the tag
  #   @return [Integer]
  # @!attribute [r] modified_datetime
  #   ISO 8601 representation of the last modified time
  #   @return [String]
  # @!attribute [r] modified_epoch
  #   UNIX epoch of the last modified time
  #   @return [Integer]
  PROPERTIES = [:tag, :count, :modified_epoch, :modified_datetime]

  include Hatena::Bookmark::Restful::V1::ResponseObject

  # The last modified time
  # @return [Time]
  def modified_at
    Time.at(self.modified_epoch)
  end
end

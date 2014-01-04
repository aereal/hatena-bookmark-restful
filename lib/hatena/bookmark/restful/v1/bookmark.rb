require "hatena/bookmark/restful/v1/response_object"

module Hatena
  module Bookmark
    module Restful
      class V1
        class Bookmark
          # @!attribute [r] comment
          #   @return [String]
          # @!attribute [r] created_datetime
          #   @return [String]
          # @!attribute [r] created_epoch
          #   @return [Integer]
          # @!attribute [r] user
          #   @return [String]
          # @!attribute [r] permalink
          #   @return [String]
          # @!attribute [r] private
          #   @return [Boolean]
          # @!attribute [r] tags
          #   @note Return value is a array of **String representation of the tag**
          #   @return [<String>]
          PROPERTIES = [:comment, :created_datetime, :created_epoch, :user, :permalink, :private, :tags]

          include Hatena::Bookmark::Restful::V1::ResponseObject
        end
      end
    end
  end
end

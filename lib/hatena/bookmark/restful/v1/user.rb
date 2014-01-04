require "hatena/bookmark/restful/v1/response_object"

module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

class Hatena::Bookmark::Restful::V1::User
  # @!attribute [r] name
  #   User's Hatena ID
  #   @return [String]
  STRING_PROPERTIES  = [:name]
  BOOLEAN_PROPERTIES = [:plususer, :private, :is_oauth_twitter, :is_oauth_evernote, :is_oauth_facebook, :is_oauth_mixi_check]
  PROPERTIES         = STRING_PROPERTIES + BOOLEAN_PROPERTIES

  include Hatena::Bookmark::Restful::V1::ResponseObject

  # @!method plususer?
  #   The user subscribed Hatena Bookmark Plus or not
  #   @return [Boolean]
  # @!method private?
  #   The user does not share his/her bookmarks with anyone or not
  #   @return [Boolean]
  # @!method oauth_twitter?
  #   Connected with Twitter using OAuth or not
  #   @return [Boolean]
  # @!method oauth_evernote?
  #   Connected with Evernote using OAuth or not
  #   @return [Boolean]
  # @!method oauth_facebook?
  #   Connected with Facebook using OAuth or not
  #   @return [Boolean]
  # @!method oauth_mixi_check?
  #   Connected with mixi check using OAuth or not
  #   @return [Boolean]
  BOOLEAN_PROPERTIES.each do |prop|
    define_method(prop.to_s.gsub(/^is_/, '')) do
      @attributes.fetch(prop)
    end
  end
end

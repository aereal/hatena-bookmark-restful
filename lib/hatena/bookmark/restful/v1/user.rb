module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

class Hatena::Bookmark::Restful::V1::User
  STRING_PROPERTIES  = [:name]
  BOOLEAN_PROPERTIES = [:plususer, :private, :is_oauth_twitter, :is_oauth_evernote, :is_oauth_facebook, :is_oauth_mixi_check]
  PROPERTIES         = STRING_PROPERTIES + BOOLEAN_PROPERTIES

  # Create a new User instance from JSON from the API
  # @return [User]
  def self.new_from_response(res)
    string_property_names = PROPERTIES.map(&:to_s)
    values = res.values_at(*string_property_names)
    attrs = Hash[ PROPERTIES.zip(values) ]
    new(attrs)
  end

  def initialize(attributes)
    @attributes = attributes
  end

  # @!attribute [r] name
  #   User's Hatena ID
  #   @return [String]
  STRING_PROPERTIES.each do |prop|
    define_method(prop) do
      @attributes.fetch(prop)
    end
  end

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

  # Fetch raw attribute value
  # @param [Symbol] name The attribute's name
  def [](name)
    @attributes[name]
  end

  # @return [Boolean]
  def ==(other)
    other.is_a?(self.class) && PROPERTIES.all? {|prop| self[prop] == other[prop] }
  end

  # @return [Hash]
  def to_hash
    @attributes
  end
end

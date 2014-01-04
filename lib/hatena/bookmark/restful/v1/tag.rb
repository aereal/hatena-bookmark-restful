module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

class Hatena::Bookmark::Restful::V1::Tag
  PROPERTIES = [:tag, :count, :modified_epoch, :modified_datetime]

  # Create a new Tag instance from JSON from the API
  # @return [Tag]
  def self.new_from_response(res)
    string_property_names = PROPERTIES.map(&:to_s)
    values = res.values_at(*string_property_names)
    attrs = Hash[ PROPERTIES.zip(values) ]
    new(attrs)
  end

  def initialize(attributes)
    @attributes = attributes
  end

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
  PROPERTIES.each do |prop|
    define_method(prop) { @attributes.fetch(prop) }
  end

  # The last modified time
  # @return [Time]
  def modified_at
    Time.at(self.modified_epoch)
  end

  # @return [Boolean]
  def ==(other)
    other.is_a?(self.class) && self.tag == other.tag
  end

  # @return [Hash]
  def to_hash
    @attributes
  end
end

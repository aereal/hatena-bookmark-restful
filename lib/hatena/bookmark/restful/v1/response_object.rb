module Hatena
  module Bookmark
    module Restful
      class V1; end
    end
  end
end

module Hatena::Bookmark::Restful::V1::ResponseObject
  module ClassMethods
    # Create a new instance from JSON from the API
    def new_from_response(res)
      properties = self.const_get(:PROPERTIES)
      names      = properties.map(&:to_s)
      values     = res.values_at(*names)
      attrs      = Hash[ properties.zip(values) ]
      new(attrs)
    end
  end

  def self.included(context)
    properties = context.const_get(:PROPERTIES)
    context.send(:extend, ClassMethods)
    properties.each do |prop|
      define_method(prop) { @attributes.fetch(prop) }
    end
  end

  def initialize(attributes)
    @attributes = attributes
  end

  # Fetch raw attribute value
  # @param [Symbol] name The attribute's name
  def [](name)
    @attributes[name]
  end

  # @return [Boolean]
  def ==(other)
    other.is_a?(self.class) && self.class.const_get(:PROPERTIES).all? {|prop| self[prop] == other[prop] }
  end

  # @return [Hash]
  def to_hash
    @attributes
  end
end

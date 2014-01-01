require 'spec_helper'

describe Hatena::Bookmark::Restful do
  it 'should have a version number' do
    Hatena::Bookmark::Restful::VERSION.should_not be_nil
  end
end

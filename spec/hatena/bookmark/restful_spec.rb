require 'spec_helper'

describe Hatena::Bookmark::Restful do
  it 'should have a version number' do
    expect(Hatena::Bookmark::Restful::VERSION).not_to be_nil
  end
end

require 'hatena/bookmark/restful/v1'
require 'json'

describe Hatena::Bookmark::Restful::V1 do
  describe "#tags" do
    subject(:client) { described_class.new }

    let(:tags) {
      {
        'tags' => [
          {
            'modified_datetime' => '2012-10-13T17:49:14',
            'modified_epoch'    => 1350150554,
            'count'             => 3,
            'tag'               => 'perl',
          },
          {
            'modified_datetime' => '2011-06-15T05:41:01',
            'modified_epoch'    => 1308116461,
            'count'             => 10,
            'tag'               => 'ruby',
          }
        ]
      }
    }

    let(:stubbed_response) {
      [
        200,
        {},
        JSON.dump(tags)
      ]
    }

    let(:test_connection) {
      Faraday.new do |builder|
        builder.adapter :test do |stubs|
          stubs.get("/1/my/tags") { stubbed_response }
        end
      end
    }

    before do
      allow(client).to receive(:connection).and_return(test_connection)
    end

    it "returns a tags" do
      expect(client.my_tags).to eq(tags)
    end
  end

  describe "#my" do
    subject(:client) { described_class.new }

    let(:user) {
      {
        'name'                => 'aereal',
        'plususer'            => true,
        'private'             => false,
        'is_oauth_twitter'    => true,
        'is_oauth_evernote'   => true,
        'is_oauth_facebook'   => true,
        'is_oauth_mixi_check' => false,
      }
    }

    let(:stubbed_response) {
      [
        200,
        {},
        JSON.dump(user)
      ]
    }

    let(:test_connection) {
      Faraday.new do |builder|
        builder.adapter :test do |stubs|
          stubs.get("/1/my") { stubbed_response }
        end
      end
    }

    before do
      allow(client).to receive(:connection).and_return(test_connection)
    end

    it "returns a user" do
      expect(client.my).to eq(user)
    end
  end
end

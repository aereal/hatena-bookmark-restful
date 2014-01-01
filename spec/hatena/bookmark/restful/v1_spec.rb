require 'hatena/bookmark/restful/v1'
require 'json'

describe Hatena::Bookmark::Restful::V1 do
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

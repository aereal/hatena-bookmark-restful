require 'hatena/bookmark/restful/v1'
require 'json'

shared_examples "a response from API" do
  subject { raise "The example group must give real `subject`" }

  let(:client) { Hatena::Bookmark::Restful::V1.new }

  let(:response_object) { raise "The example group must give real `response_object`" }

  let(:api_path) { raise "The example group must give real `api_path`" }

  let(:stubbed_response) {
    [
      200,
      {},
      JSON.dump(response_object)
    ]
  }

  let(:test_connection) {
    Faraday.new do |builder|
      builder.adapter :test do |stubs|
        stubs.get(api_path) { stubbed_response }
      end
    end
  }

  before do
    allow(client).to receive(:connection).and_return(test_connection)
  end

  it "returns a valid response object" do
    expect(subject).to eq(response_object)
  end
end

describe Hatena::Bookmark::Restful::V1 do
  describe "#bookmark" do
    it_behaves_like "a response from API" do
      subject { client.bookmark(entry_url) }

      let(:api_path) { "/1/my/bookmark" }

      let(:response_object) {
        {
          'comment' => ' Heroku の Deploy Hooks で HipChat がサポートされていた',
          'created_datetime' => '2013-12-17T23:58:54+09:00',
          'created_epoch' => 1387292334,
          'user' => 'aereal',
          'permalink' => 'http://b.hatena.ne.jp/aereal/20131217#bookmark-150288466',
          'private' => false,
          'tags' => [
            'heroku',
          ],
        }
      }

      let(:entry_url) { "https://devcenter.heroku.com/articles/deploy-hooks" }
    end
  end

  describe "#entry" do
    it_behaves_like "a response from API" do
      subject { client.entry(entry_url) }

      let(:api_path) { "/1/entry" }

      let(:response_object) {
        {
          'title'                    => %|aereal's portfolio - aereal.org|,
          'url'                      => 'http://aereal.org/',
          'entry_url'                => 'http://b.hatena.ne.jp/entry/aereal.org/',
          'count'                    => 3,
          'favicon_url'              => 'http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Faereal.org%2F',
          'smartphone_app_entry_url' => 'http://b.hatena.ne.jp/bookmarklet.touch?mode=comment&iphone_app=1&url=http%3A%2F%2Faereal.org%2F',
        }
      }

      let(:entry_url) { 'http://aereal.org/' }
    end
  end

  describe "#tags" do
    it_behaves_like "a response from API" do
      subject { client.my_tags }

      let(:api_path) { "/1/my/tags" }

      let(:response_object) {
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
    end
  end

  describe "#my" do
    it_behaves_like "a response from API" do
      subject { client.my }

      let(:response_object) {
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

      let(:api_path) { "/1/my" }
    end
  end
end

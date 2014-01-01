# encoding: utf-8

require 'hatena/bookmark/restful/v1'
require 'json'

shared_context "send a HTTP request to API" do
  subject { raise "The example group must give real `subject`" }

  let(:client) { Hatena::Bookmark::Restful::V1.new }

  let(:api_path) { raise "The example group must give real `api_path`" }

  let(:stubbed_response) {
    [
      200,
      {},
      response_body
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
end

describe Hatena::Bookmark::Restful::V1 do
  describe "#create_bookmark" do
    let(:client) { Hatena::Bookmark::Restful::V1.new }

    let(:stubbed_response) {
      [
        200,
        {},
        JSON.dump(bookmark)
      ]
    }

    let(:test_connection) {
      Faraday.new do |builder|
        builder.adapter :test do |stubs|
          stubs.post(api_path) { stubbed_response }
        end
      end
    }

    let(:api_path) { "/1/my/bookmark" }

    let(:request_params) {
      {
        url: 'http://www.hatena.ne.jp/',
        comment: 'おもしろホームページです',
        tags: %w( hatena ),
        post_twitter: false,
        post_facebook: false,
        post_mixi: false,
        post_evernote: false,
        send_mail: false,
        private: false,
      }
    }

    let(:bookmark) {
      {
        'comment' => request_params[:comment],
        'created_datetime' => '2013-12-17T23:58:54+09:00',
        'created_epoch' => 1387292334,
        'user' => 'aereal',
        'permalink' => 'http://b.hatena.ne.jp/aereal/20131217#bookmark-150288466',
        'private' => false,
        'tags' => [
          'hatena',
        ],
      }
    }

    before do
      allow(client).to receive(:connection).and_return(test_connection)
    end

    it "successfully create a new bookmark" do
      expect(client.create_bookmark(request_params)).to eq(bookmark)
    end
  end

  describe "#delete_bookmark" do
    let(:client) { Hatena::Bookmark::Restful::V1.new }

    let(:stubbed_response) {
      [
        204,
        {},
        ''
      ]
    }

    let(:test_connection) {
      Faraday.new do |builder|
        builder.adapter :test do |stubs|
          stubs.delete(api_path) { stubbed_response }
        end
      end
    }

    let(:api_path) { "/1/my/bookmark" }

    let(:entry_url) { "http://aereal.org/" }

    before do
      allow(client).to receive(:connection).and_return(test_connection)
    end

    it "successfully delete a bookmark" do
      expect(client.delete_bookmark(entry_url)).to be_true
    end
  end

  describe "#bookmark" do
    include_context "send a HTTP request to API"

    subject { client.bookmark(entry_url) }

    let(:api_path) { "/1/my/bookmark" }

    let(:bookmark) {
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

    let(:response_body) { JSON.dump(bookmark) }

    let(:entry_url) { "https://devcenter.heroku.com/articles/deploy-hooks" }

    it "is valid response from API" do
      expect(client.bookmark(entry_url)).to eq(bookmark)
    end
  end

  describe "#entry" do
    include_context "send a HTTP request to API"
    let(:api_path) { "/1/entry" }

    let(:entry) {
      {
        'title'                    => %|aereal's portfolio - aereal.org|,
        'url'                      => 'http://aereal.org/',
        'entry_url'                => 'http://b.hatena.ne.jp/entry/aereal.org/',
        'count'                    => 3,
        'favicon_url'              => 'http://cdn-ak.favicon.st-hatena.com/?url=http%3A%2F%2Faereal.org%2F',
        'smartphone_app_entry_url' => 'http://b.hatena.ne.jp/bookmarklet.touch?mode=comment&iphone_app=1&url=http%3A%2F%2Faereal.org%2F',
      }
    }

    let(:response_body) { JSON.dump(entry) }

    let(:entry_url) { 'http://aereal.org/' }

    it "is valid response from API" do
      expect(client.entry(entry_url)).to eq(entry)
    end
  end

  describe "#tags" do
    include_context "send a HTTP request to API"
    let(:api_path) { "/1/my/tags" }

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

    let(:response_body) { JSON.dump(tags) }

    it "is valid response from API" do
      expect(client.my_tags).to eq(tags)
    end
  end

  describe "#my" do
    include_context "send a HTTP request to API"

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

    let(:response_body) { JSON.dump(user) }

    let(:api_path) { "/1/my" }

    it "is valid response from API" do
      expect(client.my).to eq(user)
    end
  end
end

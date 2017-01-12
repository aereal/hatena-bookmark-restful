 * `master` status: ![master Build Status](https://travis-ci.org/aereal/hatena-bookmark-restful.png?branch=master)
 * `develop` status: ![develop Build Status](https://travis-ci.org/aereal/hatena-bookmark-restful.png?branch=develop)

# Hatena::Bookmark::Restful

A client library for [Hatena::Bookmark RESTful API](http://developer.hatena.ne.jp/ja/documents/bookmark/apis/rest).

## Installation

Add this line to your application's Gemfile:

    gem 'hatena-bookmark-restful'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hatena-bookmark-restful

## Usage

**NOTICE**: You must read and agree to [terms of services (in Japanese)](http://developer.hatena.ne.jp/ja/license) before using the API.

```
require 'hatena/bookmark/restful/v1'
CONSUMER_KEY        = 'YOUR_CONSUMER_KEY'
CONSUMER_SECRET     = 'YOUR_CONSUMER_SECRET'
ACCESS_TOKEN        = 'YOUR_ACCESS_TOKEN'
ACCESS_TOKEN_SECRET = 'YOUR_ACCESS_TOKEN_SECRET'

credentials = Hatena::Bookmark::Restful::V1::Credentials.new(
  consumer_key:        CONSUMER_KEY,
  consumer_secret:     CONSUMER_SECRET,
  access_token:        ACCESS_TOKEN,
  access_token_secret: ACCESS_TOKEN_SECRET
)
client = Hatena::Bookmark::Restful::V1.new(credentials)

client.bookmark('http://www.hatena.ne.jp/')
```

## Contributing

1. Fork it ( http://github.com/aereal/hatena-bookmark-restful/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

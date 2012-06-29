# Singly [![Build Status](https://secure.travis-ci.org/edgar/singly.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/edgar/singly.png?travis)][gemnasium]
A gem for Singly API - http://dev.singly.com

[travis]: http://travis-ci.org/edgar/singly
[gemnasium]: https://gemnasium.com/edgar/singly


## Installation

Add this line to your application's Gemfile:

    gem 'singly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install singly

## Sample Application
    require "sinatra"
    require "singly"

    enable :sessions

    CALLBACK_URL = "http://localhost:4567/oauth/callback"

    Singly.configure do |config|
      config.client_id = "YOUR_CLIENT_ID"
      config.client_secret = "YOUR_CLIENT_SECRET"
    end

    get "/" do
      '<a href="/oauth/connect">Connect with Singly</a>'
    end

    get "/oauth/connect" do
      redirect Singly.authorize_url(:redirect_uri => CALLBACK_URL)
    end

    get "/oauth/callback" do
      response = Singly.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
      session[:access_token] = response.access_token
      redirect "/feed"
    end

    get "/feed" do
      client = Singly.client(:access_token => session[:access_token])
      profiles = client.profiles

      html = "<h1>#{profiles.id}</h1>"
      html
    end

## Usage Examples
    require "rubygems"
    require "singly"

    # Get a list of the profiles linked to current account
    puts Instagram.profiles

    # All methods require authentication (either by client ID/secret or access token).
    # To get your Singly OAuth credentials, register an app at http://dev.singly.com
    Singly.configure do |config|
      config.client_id = YOUR_CLIENT_KEY
      config.client_secret = YOUR_CLIENT_SECRET
      config.access_token = YOUR_ACCESS_TOKEN
    end


## Ruby 1.8.7 and multi_json

Singly gem use [multi_json](https://github.com/intridea/multi_json),
if you plan to use singly gem with ruby 1.8.7 you need to require a supporting
library like yajl. That is because json was added to stdlib in ruby 1.9.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

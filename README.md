# Singly [![Build Status](https://secure.travis-ci.org/edgar/singly.png?branch=master)][travis]
A gem for Singly API - http://dev.singly.com

[travis]: http://travis-ci.org/edgar/singly

## Installation

Add this line to your application's Gemfile:

    gem 'singly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install singly

## Usage

TODO: Write usage instructions here

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

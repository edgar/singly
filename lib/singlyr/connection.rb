require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Singlyr
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/json; charset=utf-8", 'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |connection|
        connection.use FaradayMiddleware::OAuth2, client_id, access_token
        connection.use Faraday::Request::UrlEncoded
        connection.adapter(adapter)
        connection.use FaradayMiddleware::Mashify unless raw
        connection.use Faraday::Response::ParseJson unless raw
        #connection.use FaradayMiddleware::RaiseHttpException
      end
    end
  end
end
require File.expand_path('../singly/error', __FILE__)
require File.expand_path('../singly/configuration', __FILE__)
require File.expand_path('../singly/api', __FILE__)
require File.expand_path('../singly/client', __FILE__)

module Singly
  extend Configuration

  # Alias for Singly::Client.new
  #
  # @return [Singly::Client]
  def self.client(options={})
    Singly::Client.new(options)
  end

  # Delegate to Singly::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Singly::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end

require File.expand_path('../singlyr/error', __FILE__)
require File.expand_path('../singlyr/configuration', __FILE__)
require File.expand_path('../singlyr/api', __FILE__)
require File.expand_path('../singlyr/client', __FILE__)

module Singlyr
  extend Configuration

  # Alias for Singlyr::Client.new
  #
  # @return [Singlyr::Client]
  def self.client(options={})
    Singlyr::Client.new(options)
  end

  # Delegate to Singlyr::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Singlyr::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end

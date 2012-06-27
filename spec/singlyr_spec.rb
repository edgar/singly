require 'spec_helper'

describe Singlyr do
  after do
    Singlyr.reset
  end

  context "when delegating to a client" do

    before do
      stub_get("profiles").
       to_return(:body => fixture("profiles.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      Singlyr.profiles()
      a_get("profiles").should have_been_made
    end

    it "should return the same results as a client" do
      Singlyr.profiles().should == Singlyr::Client.new.profiles()
    end

  end

  describe ".client" do
    it "should be a Singlyr::Client" do
      Singlyr.client.should be_a Singlyr::Client
    end

  end

  describe ".adapter" do
    it "should return the default adapter" do
      Singlyr.adapter.should == Singlyr::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Singlyr.adapter = :typhoeus
      Singlyr.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Singlyr.endpoint.should == Singlyr::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Singlyr.endpoint = 'http://edgar.com.ve'
      Singlyr.endpoint.should == 'http://edgar.com.ve'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Singlyr.format.should == Singlyr::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Singlyr.format = 'xml'
      Singlyr.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Singlyr.user_agent.should == Singlyr::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Singlyr.user_agent = 'Custom User Agent'
      Singlyr.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do
    Singlyr::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Singlyr.configure do |config|
          config.send("#{key}=", key)
          Singlyr.send(key).should == key
        end
      end
    end
  end
end
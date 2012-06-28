require 'spec_helper'

describe Singly do
  after do
    Singly.reset
  end

  context "when delegating to a client" do

    before do
      stub_get("profiles").
       to_return(:body => fixture("profiles.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      Singly.profiles()
      a_get("profiles").should have_been_made
    end

    it "should return the same results as a client" do
      Singly.profiles().should == Singly::Client.new.profiles()
    end

  end

  describe ".client" do
    it "should be a Singly::Client" do
      Singly.client.should be_a Singly::Client
    end

  end

  describe ".adapter" do
    it "should return the default adapter" do
      Singly.adapter.should == Singly::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Singly.adapter = :typhoeus
      Singly.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Singly.endpoint.should == Singly::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Singly.endpoint = 'http://edgar.com.ve'
      Singly.endpoint.should == 'http://edgar.com.ve'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Singly.format.should == Singly::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Singly.format = 'xml'
      Singly.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Singly.user_agent.should == Singly::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Singly.user_agent = 'Custom User Agent'
      Singly.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do
    Singly::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Singly.configure do |config|
          config.send("#{key}=", key)
          Singly.send(key).should == key
        end
      end
    end
  end
end
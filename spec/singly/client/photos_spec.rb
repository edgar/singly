require File.expand_path('../../../spec_helper', __FILE__)

describe Singly::Client do
  before do
    @client = Singly::Client.new(:client_id => 'CID', :client_secret => 'CS', :access_token => 'AT')
  end


  describe ".photos" do
    before do
      stub_get("types/photos").
        with(:query => {:access_token => @client.access_token}).
        to_return(:body => fixture("photos-type.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.photos
      a_get("types/photos").
        with(:query => {:access_token => @client.access_token}).
        should have_been_made
    end

    it "should return a list of the photos posted by current user" do
      photos = @client.photos
      photos.should be_a Array
    end
  end

  describe ".photos_feed" do
    before do
      stub_get("types/photos_feed").
        with(:query => {:access_token => @client.access_token}).
        to_return(:body => fixture("photos_feed-type.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.photos_feed
      a_get("types/photos_feed").
        with(:query => {:access_token => @client.access_token}).
        should have_been_made
    end

    it "should return a list of the photos posted by connections of current user" do
      photos = @client.photos_feed
      photos.should be_a Array
    end
  end
end

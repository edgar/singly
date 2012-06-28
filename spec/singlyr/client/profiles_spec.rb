require File.expand_path('../../../spec_helper', __FILE__)

describe Singly::Client do
  before do
    @client = Singly::Client.new(:client_id => 'CID', :client_secret => 'CS', :access_token => 'AT')
  end

  describe ".profiles" do
    before do
      stub_get("profiles").
        with(:query => {:access_token => @client.access_token}).
        to_return(:body => fixture("profiles.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.profiles
      a_get("profiles").
        with(:query => {:access_token => @client.access_token}).
        should have_been_made
    end

    it "should return profiles info" do
      profiles = @client.profiles
      profiles.id.should == 'febef5b48e5dc000000000ff63233f35'
      profiles.twitter.should == ['111111']
      profiles.facebook.should == ['222222']
      profiles.instagram.should == ['333333']
      profiles.foursquare.should == ['444444']
    end
  end

  describe ".service_profile" do
    context "when specifi profile is linked" do
      before do
        stub_get("profiles/twitter").
          with(:query => {:access_token => @client.access_token}).
          to_return(:body => fixture("twitter_profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end

      it "should get the correct resource" do
        @client.service_profile(:twitter)
        a_get("profiles/twitter").
          with(:query => {:access_token => @client.access_token}).
          should have_been_made
      end
    end

    context "when specific profile is missing" do
      before do
        stub_get("profiles/tumblr").
          with(:query => {:access_token => @client.access_token}).
          to_return(:status => 404, :body => fixture("missing_profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end

      it "should raise NotFound exception" do
        expect {@client.service_profile(:tumblr)}.to raise_error(Singly::NotFound)
      end
    end

  end

  Singly::Client::SERVICES.each do |service|
    describe ".#{service}_profile" do
      it "should get the correct resource" do
        @client.should_receive(:service_profile).with(service).and_return(true)
        @client.send "#{service}_profile"
      end
    end
  end
end
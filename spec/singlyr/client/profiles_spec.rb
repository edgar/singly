require File.expand_path('../../../spec_helper', __FILE__)

describe Singlyr::Client do
  before do
    @client = Singlyr::Client.new(:client_id => 'CID', :client_secret => 'CS', :access_token => 'AT')
  end

  describe ".profiles" do
    context "when profile is linked" do
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

    context "when profile is missing" do
      before do
        stub_get("profiles").
          with(:query => {:access_token => @client.access_token}).
          to_return(:body => fixture("missing_profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
    end
  end

  describe ".service_profile" do
    context "called for twitter" do
      before do
        stub_get("profiles/twitter").
          with(:query => {:access_token => @client.access_token}).
          to_return(:body => fixture("twitter_profile.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end

      it "should get the correct resource" do
        @client.service_profile('twitter')
        a_get("profiles/twitter").
          with(:query => {:access_token => @client.access_token}).
          should have_been_made
      end

    end
  end

  Singlyr::Client::SERVICES.each do |service|
    describe ".#{service}_profile" do
      it "should get the correct resource" do
        @client.should_receive(:service_profile).with(service).and_return(true)
        @client.send "#{service}_profile"
      end
    end
  end
end
module Singlyr
  class Client < API

  SERVICES = [
      :facebook,
      :fitbit,
      :foursquare,
      :gcontacts, #google contacts
      :github,
      :instagram,
      :linkedin,
      :tumblr,
      :twitter,
      :wordpress
    ].freeze

    def self.service_names
      %w(twitter facebook)
    end

    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Singlyr::Client::Profiles
  end
end
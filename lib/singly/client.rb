module Singly
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

    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Singly::Client::Profiles
  end
end
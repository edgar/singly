module Singly
  class Client
    # Defines methods related to profiles
    module Profiles

      # Returns an object containing the profiles of all of the connected
      # services for the user associated with the specified access token
      #
      # @param [Hash] options the options to pass to API.
      # @option options [Boolean] :data if its true all of the raw original
      #   profile data will be fetched in one call (profiles in bulk)
      # @return [Hashie::Mash] A list of all profiles linked to current account.
      # @example Returns a list of all profiles linked to current account, including the raw original data for every profile
      #   Singly.profiles(:data => true)
      # @authenticated true
      def profiles(options={})
        get(profiles_path, options)
      end

      # Returns an object containing the profile on the remote service
      #
      # @param [Symbol] service_name the name of remote service
      # @param [Hash] options the options to pass to API.
      # @option options [Boolean] :auth if its true the response will include
      #   the current access token for the specified service
      # @return [Hashie::Mash] An object containing the profile on the remote service.
      # @example Returns an object with the twitter profile, including the current access token for twitter
      #   Singly.profiles(:twitter, :auth => true)
      # @authenticated true
      def profile(service_name, options={})
        get(profiles_path(service_name), options)
      end

      # Delete an individual profile from an account
      #
      # @param [Symbol] service_name the name of remote service
      # @param [String] service_profile_id the profile id in the remote service
      # @example Deletes the twitter profile linked to current account
      #   Singly.delete_profile(:twitter, 'twitter-id')
      # @authenticated true
      def delete_profile(service_name, service_profile_id)
        # I'm using raw=true b/c singly api returns the value true which is not a
        # valid JSON value
        post(profiles_path, {:delete => "#{service_profile_id}@#{service_name.to_s}"}, raw=true)
      end

      protected

      def profiles_path(service_name=nil)
        return "profiles" unless service_name
        "profiles/#{service_name.to_s}"
      end
    end
  end
end
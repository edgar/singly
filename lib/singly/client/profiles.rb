module Singly
  class Client
    # Defines methods related to profiles
    module Profiles
      def profiles
        get(profiles_path)
      end

      Singly::Client::SERVICES.each do |service_name|
        define_method "#{service_name.to_s}_profile" do |opts={}|
          service_profile(service_name, opts)
        end
      end

      def service_profile(service_name, opts={})
        get(profiles_path(service_name), opts)
      end

      protected

      def profiles_path(service_name=nil)
        return "profiles" unless service_name
        "profiles/#{service_name.to_s}"
      end
    end
  end
end
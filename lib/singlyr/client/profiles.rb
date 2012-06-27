module Singlyr
  class Client
    # Defines methods related to profiles
    module Profiles
      def profiles
        get("profiles")
      end

      Singlyr::Client::SERVICES.each do |service_name|
        define_method "#{service_name.to_s}_profile" do
          service_profile(service_name)
        end
      end

      def service_profile(service_name)
        get("profiles/#{service_name}")
      end

    end
  end
end
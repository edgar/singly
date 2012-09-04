module Singly
  class Client
    # Defines methods related to photos
    module Photos

      # Returns photos shared by the user associated with the token.
      # These would be images the user have posted to Facebook, Twitter,
      # Instagram, etc.
      #
      # @authenticated true
      def photos(options={})
        get(photos_path, options)
      end

      # Returns photos shared by connections of the user associated with the
      # token. These would be images your friends have posted to Facebook,
      # Twitter, Instagram, etc.
      #
      # @authenticated true
      def photos_feed(options={})
        get(photos_feed_path, options)
      end

      protected

      def photos_path
        "types/photos"
      end

      def photos_feed_path
        "types/photos_feed"
      end

    end
  end
end
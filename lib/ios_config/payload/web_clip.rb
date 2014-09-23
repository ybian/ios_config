module IOSConfig
  module Payload
    class WebClip < Base

      attr_accessor :url, :label, :is_removable, :icon

      private

      def payload_type
        "com.apple.webClip.managed"
      end

      def payload
        p = {}
        p['URL']         = @url unless @url.nil?
        p['Label']       = @label unless @label.nil?
        p['IsRemovable'] = @is_removable.nil? || @is_removable
        if @icon && File.exist?(@icon)
          p['Icon'] = File.open @icon
        end
        p
      end

    end
  end
end

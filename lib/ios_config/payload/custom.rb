module IOSConfig
  module Payload
    class Custom < Base

      attr_accessor :payload_type, :payload_version, :payload

      def initialize(attributes = {})
        attributes ||= {}
        [:payload_type, :payload].each do |attribute|
          raise ArgumentError, "#{attribute} must be specified" unless attributes[attribute]
        end

        super(attributes)
      end

      private

      def payload_version
        @payload_version || super
      end

    end
  end
end
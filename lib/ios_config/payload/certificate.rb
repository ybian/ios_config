module IOSConfig
  module Payload
    class Certificate < Base

      attr_accessor :type,           # pkcs12, caroot
                    :filename,       # Certificate filename
                    :cert_path,      # Certificate file path
                    :description,    # Certificate description
                    :displayname,    #
                    :identifier,     # Certificate identifier
                    :organization,   # Certificate organization
                    :password,       # Password to unlock certificate
                    :payload_version # Payload version

      def initialize(attributes = {})
        attributes ||= {}
        [ :type,
          :filename,
          :cert_path,
          :description,
          :displayname,
          :identifier,
          :organization ].each do |attribute|
          raise ArgumentError, "#{attribute} must be specified" unless attributes[attribute]
        end

        super(attributes)
      end

      private

      def payload
        p = { 'PayloadCertificateFileName' => @filename,
              'PayloadContent' => read_cert(@cert_path, @password),
              'PayloadDescription' => @description,
              'PayloadDisplayName' => @displayname,
              'PayloadIdentifier' => @identifier,
              'PayloadOrganization' => @organization,
            }

        p['Password'] = @password unless @password.blank?

        p
      end

      def read_cert(cert_path, password = nil)
        data = File.read(cert_path)

        # This will throw an exception if we have an incorrect password
        if !password.nil?
          OpenSSL::PKCS12.new(data, password)
        end

        StringIO.new data
      end

      def payload_type
        case @type
        when 'pkcs12'
          'com.apple.security.pkcs12'
        when 'caroot'
          'com.apple.security.root'
        else
          raise NotImplementedError
        end
      end

      def payload_version
        @payload_version || super
      end
    end
  end
end

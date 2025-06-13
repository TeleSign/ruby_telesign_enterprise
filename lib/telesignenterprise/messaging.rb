require 'telesign'
require_relative 'constants'

OMNI_MESSAGING_RESOURCE = '/v1/omnichannel'
module TelesignEnterprise

  # TeleSign's Messaging API allows you to easily send SMS messages. You can send alerts, reminders, and notifications,
  # or you can send verification messages containing one-time passcodes (OTP).
  class MessagingClient < Telesign::MessagingClient
    def initialize(customer_id,
                   api_key,
                   rest_endpoint: 'https://rest-ww.telesign.com',
                   timeout: nil,
                   source: 'ruby_telesign_enterprise',
                   sdk_version_origin: TelesignEnterprise::SDK_VERSION,
                   sdk_version_dependency: Gem.loaded_specs['telesign'].version)

      super(customer_id,
            api_key,
            rest_endpoint: rest_endpoint,
            timeout: timeout,
            source: source,
            sdk_version_origin: sdk_version_origin,
            sdk_version_dependency: sdk_version_dependency)
    end
    # Telesign Messaging allows you to easily send a message to the target recipient using any of Telesign's supported channels.
    class OmniMessagingClient < Telesign::RestClient
      def initialize(customer_id,
        api_key,
        rest_endpoint,
        timeout: nil)

        super(customer_id,
        api_key,
        rest_endpoint: rest_endpoint,
        timeout: timeout)
      end
      def omni_message(**params)
        self.post(OMNI_MESSAGING_RESOURCE, **params)
      end

      private
      def content_type
        "application/json"
      end
    end

    def omni_message (**params)
      omni_msg = OmniMessagingClient.new(@customer_id, @api_key, @rest_endpoint)
      omni_msg.omni_message(**params)
    end
  end
end
require 'telesign'

OMNI_MESSAGING_RESOURCE = '/v1/omnichannel'
module TelesignEnterprise

  # TeleSign's Messaging API allows you to easily send SMS messages. You can send alerts, reminders, and notifications,
  # or you can send verification messages containing one-time passcodes (OTP).
  class MessagingClient < Telesign::MessagingClient

    def initialize(customer_id,
                   api_key,
                   rest_endpoint: 'https://rest-ww.telesign.com',
                   timeout: nil)

      super(customer_id,
            api_key,
            rest_endpoint: rest_endpoint,
            timeout: timeout)
      @api_key = api_key
      @customer_id = customer_id
      @rest_endpoint = rest_endpoint
      @timeout = timeout
    end

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
      class_omni_msg = OmniMessagingClient.new(@customer_id, @api_key, @rest_endpoint, timeout: @timeout)
      class_omni_msg.omni_message(**params)
    end
  end
end
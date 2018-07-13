require 'telesign'

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
    end
  end
end
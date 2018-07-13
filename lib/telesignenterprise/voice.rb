require 'telesign'

module TelesignEnterprise

  # TeleSign's Voice API allows you to easily send voice messages. You can send alerts, reminders, and notifications,
  # or you can send verification messages containing time-based, one-time passcodes (TOTP).
  class VoiceClient < Telesign::VoiceClient

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
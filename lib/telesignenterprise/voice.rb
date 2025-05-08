require 'telesign'

module TelesignEnterprise

  # TeleSign's Voice API allows you to easily send voice messages. You can send alerts, reminders, and notifications,
  # or you can send verification messages containing time-based, one-time passcodes (TOTP).
  class VoiceClient < Telesign::VoiceClient

    def initialize(customer_id,
                   api_key,
                   rest_endpoint: 'https://rest-ww.telesign.com',
                   timeout: nil,
                   source: 'ruby_telesign_enterprise',
                   sdkVersionOrigin: '2.5.0',
                   sdkVersionDependency: Gem.loaded_specs['telesign'].version)

      super(customer_id,
            api_key,
            rest_endpoint: rest_endpoint,
            timeout: timeout,
            source: source,
            sdk_version_origin: sdk_version_origin,
            sdkVersionDependency: sdkVersionDependency)
    end
  end
end
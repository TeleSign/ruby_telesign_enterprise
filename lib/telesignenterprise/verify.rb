require 'telesign/rest'
require_relative 'omniverify'
require_relative 'constants'

VERIFY_SMS_RESOURCE = '/v1/verify/sms'
VERIFY_VOICE_RESOURCE = '/v1/verify/call'
VERIFY_SMART_RESOURCE = '/v1/verify/smart'
VERIFY_STATUS_RESOURCE = '/v1/verify/%{reference_id}'
VERIFY_COMPLETION_RESOURCE = '/v1/verify/completion/%{reference_id}'
VERIFY_OMNICHANNEL_RESOURCE = '/verification'

module TelesignEnterprise

  # The Verify API delivers phone-based verification and two-factor authentication using a time-based, one-time passcode
  # sent via SMS message and Voice call.
  class VerifyClient < Telesign::RestClient
    def initialize(customer_id,
                   api_key,
                   rest_endpoint: 'https://rest-ww.telesign.com',
                   timeout: nil,
                   source: 'ruby_telesign_enterprise',
                   sdk_version_origin: TelesignEnterprise::SDK_VERSION,
                   sdk_version_dependency: Gem.loaded_specs['telesign'].version,
                   rest_endpoint_verify: 'https://verify.telesign.com')

      @omniVerifyClient = OmniVerifyClient.new(customer_id, api_key, rest_endpoint: rest_endpoint_verify)
      super(customer_id,
            api_key,
            rest_endpoint: rest_endpoint,
            timeout: timeout,
            source: source,
            sdk_version_origin: sdk_version_origin,
            sdk_version_dependency: sdk_version_dependency)
    end

    # The SMS Verify API delivers phone-based verification and two-factor authentication using a time-based,
    # one-time passcode sent over SMS.
    #
    # See https://developer.telesign.com/docs/rest_api-verify-sms for detailed API documentation.
    def sms(phone_number, **params)
      self.post(VERIFY_SMS_RESOURCE,
                phone_number: phone_number,
                **params)
    end

    # The Voice Verify API delivers patented phone-based verification and two-factor authentication using a one-time
    # passcode sent over voice message.
    #
    # See https://developer.telesign.com/docs/rest_api-verify-call for detailed API documentation.
    def voice(phone_number, **params)
      self.post(VERIFY_VOICE_RESOURCE,
                phone_number: phone_number,
                **params)
    end

    # The Smart Verify web service simplifies the process of verifying user identity by integrating several TeleSign
    # web services into a single API call. This eliminates the need for you to make multiple calls to the TeleSign
    # Verify resource.
    #
    # See https://developer.telesign.com/docs/rest_api-smart-verify for detailed API documentation.
    def smart(phone_number, ucid, **params)
      self.post(VERIFY_SMART_RESOURCE,
                phone_number: phone_number,
                ucid: ucid,
                **params)
    end

    # Retrieves the verification result for any verify resource.
    #
    # See https://developer.telesign.com/docs/rest_api-verify-transaction-callback for detailed API documentation.
    def status(reference_id, **params)
      self.get(VERIFY_STATUS_RESOURCE % {:reference_id => reference_id},
               **params)
    end

    # Notifies TeleSign that a verification was successfully delivered to the user in order to help improve the
    # quality of message delivery routes.
    #
    # See https://developer.telesign.com/docs/completion-service-for-verify-products for detailed API documentation.
    def completion(reference_id, **params)
      self.put(VERIFY_COMPLETION_RESOURCE % {:reference_id => reference_id},
               **params)
    end

    # Use this action to create a verification process for the specified phone number.
    #
    # See https://developer.telesign.com/enterprise/reference/createverificationprocess for detailed API documentation.
    def create_verification_process(phone_number, **params)
      @omniVerifyClient.create_verification_process(phone_number, **params)
    end

  end
end

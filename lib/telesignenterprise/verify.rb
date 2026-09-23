require 'telesign/rest'
require_relative 'omniverify'
require_relative 'constants'

VERIFY_SMS_RESOURCE = '/v1/verify/sms'.freeze
VERIFY_VOICE_RESOURCE = '/v1/verify/call'.freeze
VERIFY_SMART_RESOURCE = '/v1/verify/smart'.freeze
VERIFY_STATUS_RESOURCE = '/v1/verify/%{reference_id}'.freeze
VERIFY_COMPLETION_RESOURCE = '/v1/verify/completion/%{reference_id}'.freeze
VERIFY_OMNICHANNEL_RESOURCE = '/verification'.freeze

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
      @omni_verify_client = OmniVerifyClient.new(customer_id, api_key, rest_endpoint: rest_endpoint_verify)
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
      post(VERIFY_SMS_RESOURCE,
           phone_number: phone_number,
           **params)
    end

    # The Voice Verify API delivers patented phone-based verification and two-factor authentication using a one-time
    # passcode sent over voice message.
    #
    # See https://developer.telesign.com/docs/rest_api-verify-call for detailed API documentation.
    def voice(phone_number, **params)
      post(VERIFY_VOICE_RESOURCE,
           phone_number: phone_number,
           **params)
    end

    # The Smart Verify web service simplifies the process of verifying user identity by integrating several TeleSign
    # web services into a single API call. This eliminates the need for you to make multiple calls to the TeleSign
    # Verify resource.
    #
    # See https://developer.telesign.com/docs/rest_api-smart-verify for detailed API documentation.
    def smart(phone_number, ucid, **params)
      post(VERIFY_SMART_RESOURCE,
           phone_number: phone_number,
           ucid: ucid,
           **params)
    end

    # Retrieves the verification result for any verify resource.
    #
    # See https://developer.telesign.com/docs/rest_api-verify-transaction-callback for detailed API documentation.
    def status(reference_id, **params)
      get(format(VERIFY_STATUS_RESOURCE, reference_id: reference_id),
          **params)
    end

    # Notifies TeleSign that a verification was successfully delivered to the user in order to help improve the
    # quality of message delivery routes.
    #
    # See https://developer.telesign.com/docs/completion-service-for-verify-products for detailed API documentation.
    def completion(reference_id, **params)
      put(format(VERIFY_COMPLETION_RESOURCE, reference_id: reference_id),
          **params)
    end

    # Use this action to create a verification process for the specified phone number.
    #
    # See https://developer.telesign.com/enterprise/reference/createverificationprocess for detailed API documentation.
    def create_verification_process(phone_number, **params)
      @omni_verify_client.create_verification_process(phone_number, **params)
    end
  end
end

require 'telesign/phoneid'
require_relative 'constants'

PHONEID_STANDARD_RESOURCE = '/v1/phoneid/standard/%{phone_number}'
PHONEID_LIVE_RESOURCE = '/v1/phoneid/live/%{phone_number}'
PHONEID_GET_INFO_PATH = '/v1/phoneid/%{phone_number}'
PHONEID_GET_INFO_PATH_ALT = '/v1/phoneid'

module TelesignEnterprise

  # A set of APIs that deliver deep phone number data attributes that help optimize the end user
  # verification process and evaluate risk.
  #
  # TeleSign PhoneID provides a wide range of risk assessment indicators on the number to help confirm user identity,
  # delivering real-time decision making throughout the number lifecycle and ensuring only legitimate users are
  # creating accounts and accessing your applications.
  class PhoneIdClient < Telesign::PhoneIdClient

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

    # The PhoneID Standard API that provides phone type and telecom carrier information to identify which phone
    # numbers can receive SMS messages and/or a potential fraud risk.
    #
    # See https://developer.telesign.com/docs/rest_phoneid-standard for detailed API documentation.
    def standard(phone_number, **params)

      self.get(PHONEID_STANDARD_RESOURCE % {:phone_number => phone_number},
               **params)
    end

    # The PhoneID Live API delivers insights such as whether a phone is active or disconnected, a device is reachable
    # or unreachable and its roaming status.
    #
    # See https://developer.telesign.com/docs/rest_api-phoneid-live for detailed API documentation.
    def live(phone_number, ucid, **params)

      self.get(PHONEID_LIVE_RESOURCE % {:phone_number => phone_number},
               ucid: ucid,
               **params)
    end

    # Enter a phone number with country code to receive detailed information about carrier, location, and other details.
    # Phone number provided in URL path: POST /v1/phoneid/{phone_number}
    #
    # See https://developer.telesign.com/enterprise/reference/submitphonenumberforidentity for detailed API documentation.
    def phone_id_path(phone_number, **params)
      params['consent'] ||= { 'method' => 1 }
      
      self.post(PHONEID_GET_INFO_PATH % {:phone_number => phone_number}, **params)
    end

    # Enter a phone number with country code to receive detailed information about carrier, location, and other details.
    # Phone number provided in body: POST /v1/phoneid
    #
    # See https://developer.telesign.com/enterprise/reference/submitphonenumberforidentityalt for detailed API documentation.
    def phone_id_body(phone_number, **params)
      params['phone_number'] = phone_number
      params['consent'] ||= { 'method' => 1 }
  
      self.post(PHONEID_GET_INFO_PATH_ALT, **params)
    end
  end
end

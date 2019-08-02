require 'telesign/phoneid'

PHONEID_STANDARD_RESOURCE = '/v1/phoneid/standard/%{phone_number}'
PHONEID_CONSENT_RESOURCE = '/consent/%{phone_number}'
PHONEID_CONSENT_HISTORY_RESOURCE = '/consent/history/%{phone_number}'
PHONEID_SCORE_RESOURCE = '/v1/phoneid/score/%{phone_number}'
PHONEID_CONTACT_RESOURCE = '/v1/phoneid/contact/%{phone_number}'
PHONEID_LIVE_RESOURCE = '/v1/phoneid/live/%{phone_number}'
PHONEID_NUMBER_DEACTIVATION_RESOURCE = '/v1/phoneid/number_deactivation/%{phone_number}'

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
                   rest_endpoint: 'https://rest.telesign.com',
                   timeout: nil)

      super(customer_id,
            api_key,
            rest_endpoint: rest_endpoint,
            timeout: timeout)
    end

    # The PhoneID Standard API that provides phone type and telecom carrier information to identify which phone
    # numbers can receive SMS messages and/or a potential fraud risk.
    #
    # See https://developer.telesign.com/docs/rest_phoneid-standard for detailed API documentation.
    def standard(phone_number, **params)

      self.get(PHONEID_STANDARD_RESOURCE % {:phone_number => phone_number},
               **params)
    end

    # The PhoneID Consent API allows you to submit and revoke consent for one or many PhoneID add-ons.
    # You can also retrieve consent information for a phone number that is of a specific type, or retrieve the
    # complete consent history for a phone number.
    def consent_send(phone_number, **params)

      self.post(PHONEID_CONSENT_RESOURCE % {:phone_number => phone_number}, **params)
    end

    def consent_search(phone_number, **params)

      self.get(PHONEID_CONSENT_RESOURCE % {:phone_number => phone_number}, **params)
    end

    def consent_history(phone_number, **params)

      self.get(PHONEID_CONSENT_HISTORY_RESOURCE % {:phone_number => phone_number}, **params)
    end

    # Score is an API that delivers reputation scoring based on phone number intelligence, traffic patterns, machine
    # learning, and a global data consortium.
    #
    # See https://developer.telesign.com/docs/rest_api-phoneid-score for detailed API documentation.
    def score(phone_number, ucid, **params)

      self.get(PHONEID_SCORE_RESOURCE % {:phone_number => phone_number}, **params)
    end

    # The PhoneID Contact API delivers contact information related to the subscriber's phone number to provide another
    # set of indicators for established risk engines.
    #
    # See https://developer.telesign.com/docs/rest_api-phoneid-contact for detailed API documentation.
    def contact(phone_number, ucid, **params)

      self.get(PHONEID_CONTACT_RESOURCE % {:phone_number => phone_number},
               ucid: ucid,
               **params)
    end

    # The PhoneID Live API delivers insights such as whether a phone is active or disconnected, a device is reachable
    # or unreachable and its roaming status.
    #
    # See https://developer.telesign.com/docs/rest_api-phoneid-live for detailed API documentation.
    def live(phone_number, ucid, **params)

      self.get(PHONEID_LIVE_RESOURCE % {:phone_number => phone_number},
               **params)
    end

    # The PhoneID Number Deactivation API determines whether a phone number has been deactivated and when, based on
    # carriers' phone number data and TeleSign's proprietary analysis.
    #
    # See https://developer.telesign.com/docs/rest_api-phoneid-number-deactivation for detailed API documentation.
    def number_deactivation(phone_number, **params)

      self.get(PHONEID_NUMBER_DEACTIVATION_RESOURCE % {:phone_number => phone_number}, **params)
    end

  end
end

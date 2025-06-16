
require 'telesign/rest'
require_relative 'constants'

PATH_CREATE_VERIFICATION_PROCESS = '/verification'
PATH_UPDATE_VERIFICATION_PROCESS = '/verification/%{reference_id}/state'
PATH_RETRIEVE_VERIFICATION_PROCESS = '/verification/%{reference_id}'

module TelesignEnterprise

  # The Telesign Verify API makes it easy for you to set up phone-based, multi-factor authentication (MFA) using multiple channels and methods.
  # See https://developer.telesign.com/enterprise/docs/verify-api-overview for detailed product documentation.

  class OmniVerifyClient < Telesign::RestClient

    def initialize(customer_id,
                   api_key,
                   rest_endpoint: 'https://verify.telesign.com',
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

    # Use this action to create a verification process for the specified phone number.
    #
    # See https://developer.telesign.com/enterprise/reference/createverificationprocess for detailed API documentation.
    def create_verification_process(phone_number, **params)
      params = params.merge({ recipient: { phone_number: phone_number } })
      params[:verification_policy] ||= [{ method: 'sms', fallback_time: 30 }]
      self.post(PATH_CREATE_VERIFICATION_PROCESS, **params)
    end

    # Use this action to retrieve a verification process for the specified reference_id.
    #
    # See https://developer.telesign.com/enterprise/reference/getverificationprocess for detailed API documentation.
    def retrieve_verification_process(reference_id, **params)
      self.get(PATH_RETRIEVE_VERIFICATION_PROCESS % {:reference_id => reference_id}, **params)
    end

    # Use this action to update a verification process for the specified reference_id.
    #
    # See https://developer.telesign.com/enterprise/reference/updateverificationprocess for detailed API documentation.
    def update_verification_process(reference_id, **params)
      self.patch(PATH_UPDATE_VERIFICATION_PROCESS % {:reference_id => reference_id}, auth_method: 'Basic', **params)
    end

    private

    def content_type
      "application/json"
    end

  end
end

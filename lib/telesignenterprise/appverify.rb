require 'telesign'
require_relative 'constants'

module TelesignEnterprise

  # App Verify is a secure, lightweight SDK that integrates a frictionless user verification process into existing
  # native mobile applications.
  class AppVerifyClient < Telesign::RestClient

    APP_VERIFY_BASE_RESOURCE = "/v1/verify/auto/voice"
    INITIATE_RESOURCE = "#{APP_VERIFY_BASE_RESOURCE}/initiate"
    FINALIZE_RESOURCE = "#{APP_VERIFY_BASE_RESOURCE}/finalize"
    FINALIZE_CALLERID_RESOURCE = "#{APP_VERIFY_BASE_RESOURCE}/finalize/callerid"
    FINALIZE_TIMEOUT_RESOURCE = "#{APP_VERIFY_BASE_RESOURCE}/finalize/timeout"

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
    
    # Send call with verification code (Initiate)
    # See https://developer.telesign.com/enterprise/reference/sendappverifycode
    def initiate(phone_number, params = {})
      post(INITIATE_RESOURCE, phone_number: phone_number, **params)
    end

    # End call (Finalize)
    # See https://developer.telesign.com/enterprise/reference/endappverifycall
    def finalize(reference_id, params = {})
      post(FINALIZE_RESOURCE, reference_id: reference_id, **params)
    end

    # Report unknown caller ID
    # See https://developer.telesign.com/enterprise/reference/reportappverifycallerid
    def report_unknown_caller_id(reference_id, unknown_caller_id, params = {})
      post(FINALIZE_CALLERID_RESOURCE, reference_id: reference_id, unknown_caller_id: unknown_caller_id, **params)
    end

    # Report timeout
    # See https://developer.telesign.com/enterprise/reference/reportappverifytimeout
    def report_timeout(reference_id)
      post(FINALIZE_TIMEOUT_RESOURCE, reference_id: reference_id)
    end

    # Get transaction status
    # See https://developer.telesign.com/enterprise/reference/getappverifystatus
    def get_transaction_status(reference_id)
      get("#{APP_VERIFY_BASE_RESOURCE}/#{reference_id}")
    end

  end
end
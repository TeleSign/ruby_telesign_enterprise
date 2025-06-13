require 'telesign'
require_relative 'constants'

module TelesignEnterprise

  # App Verify is a secure, lightweight SDK that integrates a frictionless user verification process into existing
  # native mobile applications.
  class AppVerifyClient < Telesign::AppVerifyClient

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

  end
end
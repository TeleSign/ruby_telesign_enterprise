require 'telesign'

module TelesignEnterprise

  # App Verify is a secure, lightweight SDK that integrates a frictionless user verification process into existing
  # native mobile applications.
  class AppVerifyClient < Telesign::AppVerifyClient

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
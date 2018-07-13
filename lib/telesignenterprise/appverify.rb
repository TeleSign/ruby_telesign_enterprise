require 'telesign'

module TelesignEnterprise

  # App Verify is a secure, lightweight SDK that integrates a frictionless user verification process into existing
  # native mobile applications.
  class AppVerifyClient < Telesign::AppVerifyClient

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
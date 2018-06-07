require 'telesign'

module TelesignEnterprise

  # Score provides risk information about a specified phone number.
  class ScoreClient < Telesign::ScoreClient

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
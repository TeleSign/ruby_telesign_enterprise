require_relative 'test_helper'

class TestScore < TelesignEnterpriseTestCase 
  def setup
    super
    @account_lifecycle_event = 'create'
    @score_client = TelesignEnterprise::ScoreClient.new(@customer_id,
                                                        @api_key,
                                                        rest_endpoint: 'https://detect.telesign.com')
  end

  def test_score_success

    stub_request(:post, "https://detect.telesign.com/intelligence/phone")
      .with(
        body: hash_including({
          'phone_number' => @phone_number,
          'account_lifecycle_event' => @account_lifecycle_event
        }),
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      .to_return(
        status: 200,
        body: '{"risk": {"level": "low", "recommendation": "allow"}}',
        headers: { 'Content-Type' => 'application/json' }
      )

    response = @score_client.score(@phone_number, @account_lifecycle_event)

    puts "Response status code: #{response.status_code}"
    puts "Response headers: #{response.headers}"
    puts "Response body: #{response.body}"
    puts "Parsed JSON response: #{response.json}"

    assert response.ok
    assert_equal 'low', response.json['risk']['level']
    assert_equal 'allow', response.json['risk']['recommendation']

    assert_requested :post, "https://detect.telesign.com/intelligence/phone"
    assert_requested :post, "https://detect.telesign.com/intelligence/phone",
                    body: hash_including({
                      'phone_number' => @phone_number,
                      'account_lifecycle_event' => @account_lifecycle_event
                    })
    assert_requested :post, "https://detect.telesign.com/intelligence/phone",
                    headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "https://detect.telesign.com/intelligence/phone",
                    headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "https://detect.telesign.com/intelligence/phone",
                    headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "https://detect.telesign.com/intelligence/phone",
                    headers: {'Date' => /.*\S.*/}
  end
end
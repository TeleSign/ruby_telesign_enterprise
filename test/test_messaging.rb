require_relative 'test_helper'

class TestMessaging < TelesignEnterpriseTestCase
  
  def test_messaging

    stub_request(:post, 'localhost/v1/messaging').to_return(body: '{}')

    client = TelesignEnterprise::MessagingClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.message(@phone_number, 'Test Message', 'ARN')

    assert_requested :post, "http://localhost/v1/messaging"
    assert_requested :post, "http://localhost/v1/messaging", body: "phone_number=#{@phone_number}&message=Test+Message&message_type=ARN"
    assert_requested :post, "http://localhost/v1/messaging", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/messaging", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/messaging", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/messaging", headers: {'Date' => /.*\S.*/}
  end
end
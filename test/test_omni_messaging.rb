require_relative 'test_helper'

class TestOmniMessaging < TelesignEnterpriseTestCase
  def test_messaging_omnichannel

    stub_request(:post, 'localhost/v1/omnichannel').to_return(body: '{}')

    client = TelesignEnterprise::MessagingClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')
    params = {message: { sms: { template: 'text', parameters: { text: 'Test Message'} } },
              recipient: { phone_number: @phone_number },
              'channels'=>[{channel: 'sms', fallback_time: 300 }],
              message_type: 'ARN'
            }
    client.omni_message(**params)

    assert_requested :post, "http://localhost/v1/omnichannel"
    assert_requested :post, "http://localhost/v1/omnichannel", body: '{"message":{"sms":{"template":"text","parameters":{"text":"Test Message"}}},"recipient":{"phone_number":"1234567890"},"channels":[{"channel":"sms","fallback_time":300}],"message_type":"ARN"}'
    assert_requested :post, "http://localhost/v1/omnichannel", headers: {'Content-Type' => 'application/json'}
    assert_requested :post, "http://localhost/v1/omnichannel", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/omnichannel", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/omnichannel", headers: {'Date' => /.*\S.*/}
  end

  def test_messaging_status

    stub_request(:get, 'localhost/v1/messaging/REFERENCE_ID').to_return(body: '{}')

    client = TelesignEnterprise::MessagingClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.status('REFERENCE_ID')

    assert_requested :get, "http://localhost/v1/messaging/REFERENCE_ID"
    assert_requested :get, "http://localhost/v1/messaging/REFERENCE_ID", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/messaging/REFERENCE_ID", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/messaging/REFERENCE_ID", headers: {'Date' => /.*\S.*/}
  end
end
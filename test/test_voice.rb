require_relative 'test_helper'

class TestVoice < TelesignEnterpriseTestCase

  def test_voice

    stub_request(:post, 'localhost/v1/voice').to_return(body: '{}')

    client = TelesignEnterprise::VoiceClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.call(@phone_number, 'Test Message', 'ARN')

    assert_requested :post, "http://localhost/v1/voice"
    assert_requested :post, "http://localhost/v1/voice", body: "phone_number=#{@phone_number}&message=Test+Message&message_type=ARN"
    assert_requested :post, "http://localhost/v1/voice", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/voice", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/voice", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/voice", headers: {'Date' => /.*\S.*/}
  end

  def test_voice_status

    stub_request(:get, 'localhost/v1/voice/REFERENCE_ID').to_return(body: '{}')

    client = TelesignEnterprise::VoiceClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.status('REFERENCE_ID')

    assert_requested :get, "http://localhost/v1/voice/REFERENCE_ID"
    assert_requested :get, "http://localhost/v1/voice/REFERENCE_ID", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/voice/REFERENCE_ID", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/voice/REFERENCE_ID", headers: {'Date' => /.*\S.*/}
  end

end

  
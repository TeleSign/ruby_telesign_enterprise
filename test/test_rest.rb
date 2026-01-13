require 'uuid'
require 'time'
require 'test/unit'
require 'webmock/test_unit'

require 'telesignenterprise'

class TestRest < Test::Unit::TestCase

  def setup
    @customer_id = 'FFFFFFFF-EEEE-DDDD-1234-AB1234567890'
    @api_key = 'EXAMPLE----TE8sTgg45yusumoN6BYsBVkh+yRJ5czgsnCehZaOYldPJdmFh6NeX8kunZ2zU1YWaUw/0wV6xfw=='
    @phone_number = '1234567890'
    @reference_id = '0123456789ABCDEF0123456789ABCDEF'
  end

  def test_phoneid_standard
    stub_request(:get, "localhost/v1/phoneid/standard/#{@phone_number}").to_return(body: '{}')

    client = TelesignEnterprise::PhoneIdClient.new(@customer_id,
                                                   @api_key,
                                                   rest_endpoint: 'http://localhost')
    client.standard(@phone_number)
    assert_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}"
    assert_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}", body: ''
    assert_not_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}", headers: {'Content-Type' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/standard/#{@phone_number}", headers: {'Date' => /.*\S.*/}
  end

  def test_phoneid_score

    stub_request(:get, "localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL").to_return(body: '{}')

    client = TelesignEnterprise::PhoneIdClient.new(@customer_id,
                                                   @api_key,
                                                   rest_endpoint: 'http://localhost')

    client.score(@phone_number, 'TOOL')

    assert_requested :get, "http://localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL"
    assert_not_requested :get, "http://localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL", headers: {'Content-Type' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/score/#{@phone_number}?ucid=TOOL", headers: {'Date' => /.*\S.*/}
  end

  def test_score

    stub_request(:post, "localhost/v1/score/#{@phone_number}").to_return(body: '{}')

    client = TelesignEnterprise::ScoreClient.new(@customer_id,
                                                   @api_key,
                                                   rest_endpoint: 'http://localhost')

    client.score(@phone_number, 'create')

    assert_requested :post, "http://localhost/v1/score/#{@phone_number}"
    assert_requested :post, "http://localhost/v1/score/#{@phone_number}", body: 'account_lifecycle_event=create'
    assert_requested :post, "http://localhost/v1/score/#{@phone_number}", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/score/#{@phone_number}", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/score/#{@phone_number}", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/score/#{@phone_number}", headers: {'Date' => /.*\S.*/}
  end

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

  def test_verify_status_with_verify_code
    stub_request(:get, 'localhost/v1/verify/REFERENCE_ID?verify_code=12345').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.status('REFERENCE_ID', verify_code: '12345')

    assert_requested :get, "http://localhost/v1/verify/REFERENCE_ID?verify_code=12345"
    assert_requested :get, "http://localhost/v1/verify/REFERENCE_ID?verify_code=12345", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/verify/REFERENCE_ID?verify_code=12345", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/verify/REFERENCE_ID?verify_code=12345", headers: {'Date' => /.*\S.*/}
  end

  def test_app_verify_status

    stub_request(:get, 'localhost/v1/mobile/verification/status/EXTERNAL_ID').to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                               @api_key,
                                               rest_endpoint: 'http://localhost')

    client.status('EXTERNAL_ID')

    assert_requested :get, "http://localhost/v1/mobile/verification/status/EXTERNAL_ID"
    assert_requested :get, "http://localhost/v1/mobile/verification/status/EXTERNAL_ID", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/mobile/verification/status/EXTERNAL_ID", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/mobile/verification/status/EXTERNAL_ID", headers: {'Date' => /.*\S.*/}
  end

  def test_create_verification_process

    stub_request(:post, 'localhost/verification').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                               @api_key,
                                               rest_endpoint: 'http://localhost',
                                               rest_endpoint_verify: 'http://localhost')

    client.create_verification_process(@phone_number)

    assert_requested :post, "http://localhost/verification"
    assert_requested :post, "http://localhost/verification", body: '{"recipient":{"phone_number":"1234567890"},"verification_policy":[{"method":"sms","fallback_time":30}]}'
    assert_requested :post, "http://localhost/verification", headers: {'Content-Type' => 'application/json'}
    assert_requested :post, "http://localhost/verification", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/verification", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/verification", headers: {'Date' => /.*\S.*/}
  end

  def test_retrieve_verification_process

    stub_request(:get, "localhost/verification/#{@reference_id}").to_return(body: '{}')

    client = TelesignEnterprise::OmniVerifyClient.new(@customer_id,
                                               @api_key,
                                               rest_endpoint: 'http://localhost')

    client.retrieve_verification_process(@reference_id)

    assert_requested :get, "localhost/verification/#{@reference_id}"
    assert_requested :get, "localhost/verification/#{@reference_id}", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "localhost/verification/#{@reference_id}", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "localhost/verification/#{@reference_id}", headers: {'Date' => /.*\S.*/}
  end

  def test_update_verification_process

    stub_request(:patch, "localhost/verification/#{@reference_id}").to_return(body: '{}')
    stub_request(:patch, "localhost/verification/#{@reference_id}/state").to_return(body: '{}')


    client = TelesignEnterprise::OmniVerifyClient.new(@customer_id,
                                               @api_key,
                                               rest_endpoint: 'http://localhost')

    params = {
      action: 'finalize',
      security_factor: '123456'
    }                                

    client.update_verification_process(@reference_id, **params)

    assert_requested :patch, "localhost/verification/#{@reference_id}/state"
    assert_requested :patch, "localhost/verification/#{@reference_id}/state", headers: {'x-ts-auth-method' => 'Basic'}
    assert_requested :patch, "localhost/verification/#{@reference_id}/state", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :patch, "localhost/verification/#{@reference_id}/state", headers: {'Date' => /.*\S.*/}
  end

  def test_phone_id_path
    stub_request(:post, "localhost/v1/phoneid/#{@phone_number}").to_return(body: '{}')

    client = TelesignEnterprise::PhoneIdClient.new(@customer_id, @api_key, rest_endpoint: 'http://localhost')
    client.phone_id_path(@phone_number)

    assert_requested :post, "http://localhost/v1/phoneid/#{@phone_number}"
    assert_requested :post, "http://localhost/v1/phoneid/#{@phone_number}", headers: {'Content-Type' => 'application/json'}
    assert_requested :post, "http://localhost/v1/phoneid/#{@phone_number}", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/phoneid/#{@phone_number}", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/phoneid/#{@phone_number}", headers: {'Date' => /.*\S.*/}
  end

  def test_phone_id_body
    stub_request(:post, "localhost/v1/phoneid").to_return(body: '{}')

    client = TelesignEnterprise::PhoneIdClient.new(@customer_id, @api_key, rest_endpoint: 'http://localhost')
    client.phone_id_body(@phone_number)

    assert_requested :post, "http://localhost/v1/phoneid"
    assert_requested :post, "http://localhost/v1/phoneid", headers: {'Content-Type' => 'application/json'}
    assert_requested :post, "http://localhost/v1/phoneid", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/phoneid", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/phoneid", headers: {'Date' => /.*\S.*/}
  end

end

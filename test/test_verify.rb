require_relative 'test_helper'

class TestVerify < TelesignEnterpriseTestCase
  def test_verify_sms
    stub_request(:post, 'localhost/v1/verify/sms').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.sms(@phone_number)

    assert_requested :post, "http://localhost/v1/verify/sms"
    assert_requested :post, "http://localhost/v1/verify/sms", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/sms", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/sms", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/sms", headers: {'Date' => /.*\S.*/}
  end

  def test_verify_voice
    stub_request(:post, 'localhost/v1/verify/call').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.voice(@phone_number)

    assert_requested :post, "http://localhost/v1/verify/call"
    assert_requested :post, "http://localhost/v1/verify/call", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/call", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/call", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/call", headers: {'Date' => /.*\S.*/}
  end

  def test_verify_smart
    stub_request(:post, 'localhost/v1/verify/smart').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.smart(@phone_number, 'CA')

    assert_requested :post, "http://localhost/v1/verify/smart"
    assert_requested :post, "http://localhost/v1/verify/smart", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/smart", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/smart", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/smart", headers: {'Date' => /.*\S.*/}
  end

  def test_verify_completion
    stub_request(:put, 'localhost/v1/verify/completion/REFERENCE_ID').to_return(body: '{}')

    client = TelesignEnterprise::VerifyClient.new(@customer_id,
                                                 @api_key,
                                                 rest_endpoint: 'http://localhost')

    client.completion('REFERENCE_ID')

    assert_requested :put, "http://localhost/v1/verify/completion/REFERENCE_ID"
    assert_requested :put, "http://localhost/v1/verify/completion/REFERENCE_ID", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :put, "http://localhost/v1/verify/completion/REFERENCE_ID", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :put, "http://localhost/v1/verify/completion/REFERENCE_ID", headers: {'Date' => /.*\S.*/}
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
end
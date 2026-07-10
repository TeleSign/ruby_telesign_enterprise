require_relative 'test_helper'

class TestOmniVerify < TelesignEnterpriseTestCase

  def test_create_verification_process

    stub_request(:post, 'localhost/verification').to_return(body: '{}')

    client = TelesignEnterprise::OmniVerifyClient.new(@customer_id,
                                                      @api_key,
                                                      rest_endpoint: 'http://localhost')

    client.create_verification_process(@phone_number)

    assert_requested :post, "http://localhost/verification"
    assert_requested :post, "http://localhost/verification", body: '{"recipient":{"phone_number":"1234567890"},"verification_policy":[{"method":"sms","fallback_time":30}]}'
    assert_requested :post, "http://localhost/verification", headers: {'Content-Type' => 'application/json'}
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

end
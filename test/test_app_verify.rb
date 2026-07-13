require_relative 'test_helper'

class TestAppVerify < TelesignEnterpriseTestCase

  def test_app_verify_initiate
    stub_request(:post, "localhost/v1/verify/auto/voice/initiate").to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.initiate(@phone_number)

    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate", body: "phone_number=#{@phone_number}"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/initiate", headers: {'Date' => /.*\S.*/}
  end

  def test_app_verify_finalize
    stub_request(:post, "localhost/v1/verify/auto/voice/finalize").to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.finalize(@reference_id)

    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize", body: "reference_id=#{@reference_id}"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize", headers: {'Date' => /.*\S.*/}
  end

  def test_app_verify_report_unknown_caller_id
    stub_request(:post, "localhost/v1/verify/auto/voice/finalize/callerid").to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    unknown_caller_id = '15551234567'
    client.report_unknown_caller_id(@reference_id, unknown_caller_id)

    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid", body: "reference_id=#{@reference_id}&unknown_caller_id=#{unknown_caller_id}"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/callerid", headers: {'Date' => /.*\S.*/}
  end

  def test_app_verify_report_timeout
    stub_request(:post, "localhost/v1/verify/auto/voice/finalize/timeout").to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.report_timeout(@reference_id)

    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout", body: "reference_id=#{@reference_id}"
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout", headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :post, "http://localhost/v1/verify/auto/voice/finalize/timeout", headers: {'Date' => /.*\S.*/}
  end

  def test_app_verify_get_transaction_status
    stub_request(:get, "localhost/v1/verify/auto/voice/#{@reference_id}").to_return(body: '{}')

    client = TelesignEnterprise::AppVerifyClient.new(@customer_id,
                                                     @api_key,
                                                     rest_endpoint: 'http://localhost')

    client.get_transaction_status(@reference_id)

    assert_requested :get, "http://localhost/v1/verify/auto/voice/#{@reference_id}"
    assert_not_requested :get, "http://localhost/v1/verify/auto/voice/#{@reference_id}", headers: {'Content-Type' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/verify/auto/voice/#{@reference_id}", headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/verify/auto/voice/#{@reference_id}", headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/verify/auto/voice/#{@reference_id}", headers: {'Date' => /.*\S.*/}
  end

end

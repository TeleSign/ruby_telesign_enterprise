require_relative 'test_helper'

class TestPhoneId < TelesignEnterpriseTestCase
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


  def test_phoneid_live
    ucid = 'BACF'
    stub_request(:get, "localhost/v1/phoneid/live/#{@phone_number}").with(query: {'ucid' => ucid}).to_return(body: '{}')

    client = TelesignEnterprise::PhoneIdClient.new(@customer_id,
                                                   @api_key,
                                                   rest_endpoint: 'http://localhost')
    client.live(@phone_number, ucid)
    assert_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", query: {'ucid' => ucid}
    assert_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", query: {'ucid' => ucid}, body: ''
    assert_not_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", headers: {'Content-Type' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", query: {'ucid' => ucid}, headers: {'x-ts-auth-method' => 'HMAC-SHA256'}
    assert_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", query: {'ucid' => ucid}, headers: {'x-ts-nonce' => /.*\S.*/}
    assert_requested :get, "http://localhost/v1/phoneid/live/#{@phone_number}", query: {'ucid' => ucid}, headers: {'Date' => /.*\S.*/}
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
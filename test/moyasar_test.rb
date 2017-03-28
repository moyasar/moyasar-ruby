require 'test_helper'

class MoyasarTest < Minitest::Test
  include ServerStubs

  def teardown
    Moyasar.api_key = nil
  end

  def test_that_it_has_a_version_number
    refute_nil ::Moyasar::VERSION
  end

  def test_should_accept_api_key
    refute_nil Moyasar.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
  end

  def test_request_should_throw_exception_if_key_is_nil
    stub_server_request(:payments, status: 401)
    Moyasar.api_key = nil

    assert_raises Moyasar::AuthenticationError do
      Moyasar.request(:get, '/v1/payments')
    end
  end

  def test_request_should_read_api_key_class_variable_if_key_not_given
    stub_server_request(:payments, key: TEST_KEY)

    Moyasar.api_key = TEST_KEY
    response = Moyasar.request :get, '/v1/payments'

    assert_equal 200, response.code
  end

  def test_request_should_raise_authentication_error_when_use_wrong_api_key
    stub_server_request(:payments, key: 'WrongKey', status: 401)

    assert_raises Moyasar::AuthenticationError do
      Moyasar.request(:get, '/v1/payments', key: 'WrongKey')
    end
  end

  def test_request_return_success_when_correct_key_given
    stub_server_request(:payments, key: TEST_KEY)

    response = Moyasar.request(:get, '/v1/payments', key: TEST_KEY)

    assert_equal 200, response.code
  end

  def test_request_should_return_json_object
    stub_server_request(:payments, key: TEST_KEY)

    response = Moyasar.request(:get, '/v1/payments', key: TEST_KEY)

    assert_instance_of Hash, response.body
  end

end

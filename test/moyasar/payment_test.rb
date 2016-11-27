require 'test_helper'

class PaymentTest < Minitest::Test
  include ServerStubs

  def setup
    Moyasar.api_key = TEST_KEY
  end

  def test_create_should_return_intiated_payment_for_sadad_source
    params = { 
      amount: 1000, currency: 'SAR', description: 'Test',
      source: {type: 'sadad', username: 'u3041555Xolp'}
    }

    stub_server_request(:payment, key: TEST_KEY, body: params, status: 201)

    payment = Moyasar::Payment.create params

    assert_instance_of Moyasar::Payment, payment
    assert_equal 'initiated', payment.status
  end

  def test_create_with_amount_less_than_100_cent_should_raise_validation_errror
    params = {
      amount: 90, currency: 'SAR', description: 'Test',
      source: {type: 'sadad', username: 'u3041555Xolp'}
    }

    stub_server_request(:payment, key: TEST_KEY, body: params, status: 400)
    # WebMock.allow_net_connect!

    err = assert_raises Moyasar::InvalidRequestError do
      Moyasar::Payment.create params
    end

    assert_match /Validation Failed: amount must be greater than 99/, err.to_s
    assert_match /Validation Failed: amount must be greater than 99/, err.message
  end

  def test_list_should_return_list_of_payment_objects
    stub_server_request(:payments, key: TEST_KEY, status: 200)
    
    payments = Moyasar::Payment.list

    assert_instance_of Array, payments
    assert_instance_of Moyasar::Payment, payments.first
  end

  def test_find_should_return_payemnt_object_if_id_is_correct
    stub_server_request(:payment, key: TEST_KEY, status: 200)

    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
    payment = Moyasar::Payment.find(id)

    assert_equal id, payment.id
  end

  def test_update_should_update_payment_description
    stub_server_request(:payment, key: TEST_KEY, status: 200)

    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
    payment = Moyasar::Payment.find(id)

    updated = payment.update(description: 'test updated')

    assert_equal true, updated
  end

end
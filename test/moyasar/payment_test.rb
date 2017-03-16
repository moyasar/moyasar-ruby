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

    assert_match (/Validation Failed: amount must be greater than 99/i), err.to_s
    assert_match (/Validation Failed: amount must be greater than 99/i), err.message
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

  def test_refund_should_operate_normally_by_recharging_back_all_amount_as_a_default
    stub_server_request(:payment, key: TEST_KEY, status: 200)

    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
    original = Moyasar::Payment.find(id)

    params = { refunded: original.amount }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 200)
    refunded = Moyasar::Payment.refund(id)

    assert_instance_of Moyasar::Payment, refunded

    # TODO: refactor stubs ..
    # ===
    # Give a succeeded payment and (real api call / fack stub),
    # the following assertion should hold true.
    # ===
    # assert_equal original.amount, refunded.refunded
  end

  def test_refund_should_accept_partial_refund_amounts
    stub_server_request(:payment, key: TEST_KEY, status: 200)

    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
    original = Moyasar::Payment.find(id)
    half_refund = original.amount - (original.amount / 2)

    params = { refunded: half_refund }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 200)

    refunded = Moyasar::Payment.refund(id)

    assert_instance_of Moyasar::Payment, refunded
    # TODO: refactor stubs ..
    # assert_equal refunded.refunded, half_refund
  end

  def xtest_refund_with_failed_payment_should_raise_invalid_request_error
    # TODO: refactor stubs & improve ::Moyasar error reporting ..
    # skip 'stubs need refactoring in order for this api error -and others- to be covered'

    params = { status: 'failed' }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 400)

    err = assert_raises Moyasar::InvalidRequestError do
      id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
      Moyasar::Payment.refund(id)
    end
    assert_equal 400, err.code
    assert_equal 'invalid_request_error', err.type
    assert_match (/failed payment can't be refuneded/i), err
  end
end

require 'test_helper'

class PaymentTest < Minitest::Test
  include ServerStubs

  def setup
    Moyasar.api_key = TEST_KEY
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

    params = { payment_status: 'refunded', refunded: original.amount }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 200)

    refunded = Moyasar::Payment.refund(id, amount: params[:refunded])

    assert_instance_of Moyasar::Payment, refunded
    assert_equal 'refunded', refunded.status
    assert_equal original.amount, refunded.refunded
  end

  def test_refund_should_accept_partial_refund_amounts
    stub_server_request(:payment, key: TEST_KEY, status: 200)

    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
    original = Moyasar::Payment.find(id)
    half_refund = original.amount - (original.amount / 2)

    params = { payment_status: 'refunded', refunded: half_refund }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 200)

    refunded = Moyasar::Payment.refund(id)

    assert_instance_of Moyasar::Payment, refunded
    assert_equal 'refunded', refunded.status
    assert_equal refunded.refunded, half_refund
  end

  def test_refund_with_failed_payment_should_raise_invalid_request_error
    params = { payment_status: 'failed' }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 400, error_message: "failed payment can't be refuneded")

    err = assert_raises Moyasar::InvalidRequestError do
      id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'
      Moyasar::Payment.refund(id)
    end
    assert_equal 400, err.http_code
    assert_equal 'invalid_request_error', err.type
    assert_match (/failed payment can't be refuneded/i), err.to_s
  end

  def test_eqaulity_check_holds_among_identical_payments_only
    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'

    stub = stub_server_request(:payment, key: TEST_KEY, status: 200)
    payment_one = Moyasar::Payment.find(id)
    remove_stub(stub)

    stub_server_request(:payment, key: TEST_KEY, status: 200)
    payment_two = Moyasar::Payment.find(id)

    assert_equal payment_one, payment_two
  end

  def test_eqaulity_check_differentiate_non_identical_payments
    id = '328f5dca-91ec-435d-b13f-86052a1d0f7b'

    stub = stub_server_request(:payment, key: TEST_KEY, status: 200)
    payment_one = Moyasar::Payment.find(id)
    remove_stub(stub)

    params = { source: { username: 'another_user' } }
    stub_server_request(:payment, key: TEST_KEY, body: params, status: 200)
    payment_two = Moyasar::Payment.find(id)

    refute_equal payment_one, payment_two
    refute_equal payment_one, Object.new
  end
end

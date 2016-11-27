require 'test_helper'

class PaymentTest < Minitest::Test
  def setup
    Moyasar.api_key = TEST_KEY
  end

  def test_create_should_return_intiated_payment_for_sadad_source
    payment = Moyasar::Payment.create amount: 1000, currency: 'SAR', description: 'Test',
                                      source: {type: 'sadad', username: 'u3041555Xolp'}

    assert_instance_of Moyasar::Payment, payment
    assert_equal 'initiated', payment.status
  end

  def test_create_with_amount_less_than_100_cent_should_raise_validation_errror
    err = assert_raises Moyasar::InvalidRequestError do |exception|
      payment = Moyasar::Payment.create amount: 90, currency: 'SAR', description: 'Test',
                                        source: {type: 'sadad', username: 'u3041555Xolp'}
    end

    assert_match /Validation Failed: amount must be greater than 99/, err.to_s
    assert_match /Validation Failed: amount must be greater than 99/, err.message
  end

  def test_list_should_return_list_of_payment_objects
    payments = Moyasar::Payment.list

    assert_instance_of Array, payments
    assert_instance_of Moyasar::Payment, payments.first
  end

  def test_list_should_return_empty_array_if_there_is_no_payments
    Moyasar.api_key = EMPTY_ACCOUNT_TEST_KEY
    assert_equal [], Moyasar::Payment.list
  end

  def test_find_should_return_payemnt_object_if_id_is_correct
    payment_from_list = Moyasar::Payment.list.first
    payment = Moyasar::Payment.find(payment_from_list.id)
    
    # assert_equal payment_from_list, payment
    assert_equal payment_from_list.id, payment.id
  end

  def test_update_should_update_payment_description
    payment = Moyasar::Payment.list.first

    descr = "test update payment description #{DateTime.now}"

    updated = payment.update(description: descr)

    assert_equal true, updated
    assert_equal descr, Moyasar::Payment.find(payment.id).description
  end

end
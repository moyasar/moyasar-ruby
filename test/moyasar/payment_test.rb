require 'test_helper'

class PaymentTest < Minitest::Test
  def test_payment_has_create_method
    assert_equal :create, Moyasar::Payment.create
  end
end
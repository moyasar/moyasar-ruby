require 'test_helper'

class InvoiceTest < Minitest::Test
  def setup
    Moyasar.api_key = TEST_KEY
  end

  def test_create_should_return_intiated_invoice_for_sadad_source
    invoice = Moyasar::invoice.create amount: 1000, currency: 'SAR', description: 'Test',
                                      source: {type: 'sadad', username: 'u3041555Xolp'}

    assert_instance_of Moyasar::Invoice, invoice
    assert_equal 'initiated', invoice.status
  end

  def test_list_should_return_list_of_invoice_objects
    invoices = Moyasar::invoice.list

    assert_instance_of Array, invoices
    assert_instance_of Moyasar::invoice, invoices.first
  end
  
  def test_list_should_return_empty_array_if_there_is_no_invoices
    Moyasar.api_key = EMPTY_ACCOUNT_TEST_KEY
    assert_equal [], Moyasar::invoice.list
  end
  
  def test_find_should_return_payemnt_object_if_id_is_correct
    invoice_from_list = Moyasar::invoice.list.first
    invoice = Moyasar::invoice.find(invoice_from_list.id)
    
    # assert_equal invoice_from_list, invoice
    assert_equal invoice_from_list.id, invoice.id
  end
  
  def test_update_should_update_invoice_description
    invoice = Moyasar::invoice.list.first

    descr = "test update invoice description #{DateTime.now}"

    updated = invoice.update(description: descr)

    assert_equal true, updated
    assert_equal descr, Moyasar::invoice.find(invoice.id).description
  end

end
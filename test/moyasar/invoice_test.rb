require 'test_helper'

class InvoiceTest < Minitest::Test
  include ServerStubs

  def setup
    Moyasar.api_key = TEST_KEY
  end

  def test_create_should_return_intiated_invoice_for_sadad_source
    params = {amount: 1000, currency: 'SAR', description: 'Test'}

    stub_server_request(:invoice, key: TEST_KEY, body: params, status: 201)

    invoice = Moyasar::Invoice.create params

    assert_instance_of Moyasar::Invoice, invoice
    assert_equal 'initiated', invoice.status
  end

  def test_list_should_return_list_of_invoice_objects
    stub_server_request(:invoices, key: TEST_KEY, status: 200)

    invoices = Moyasar::Invoice.list

    assert_instance_of Array, invoices
    assert_instance_of Moyasar::Invoice, invoices.first
  end

  def test_find_should_return_payemnt_object_if_id_is_correct
    stub_server_request(:invoice, key: TEST_KEY, status: 200)

    id = '1b82356d-b5fd-46f8-bde9-3680d62f289a'
    invoice = Moyasar::Invoice.find(id)

    # assert_equal invoice_from_list, invoice
    assert_equal id, invoice.id
  end

  def test_update_should_update_invoice_description
    stub_server_request(:invoice, key: TEST_KEY, status: 200)

    id = '1b82356d-b5fd-46f8-bde9-3680d62f289a'
    invoice = Moyasar::Invoice.find(id)

    updated = invoice.update(description: 'test updated')

    assert_equal true, updated
  end

end

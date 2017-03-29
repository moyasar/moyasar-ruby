require 'moyasar_fixtures'

module ServerStubs
  include MoyasarFixtures

  API_URI = /api(mig)?\.moyasar\.com\/v1\/.*/

  def stub_server_request(resource, key: '', status: 200, body: {}, error_message: nil, errors: nil)
    case status
    when 200..201 then response = ok_response(resource, status, body)
    when 400..429 then response = error_response(status, error_message, errors)
    end

    stub_request(:any, API_URI).with(basic_auth: [key, '']).to_return(response)
  end

  def remove_stub(stub)
    remove_request_stub(stub)
  end

  private

  def ok_response(resource, status, body)
    bindings = {status: status, body: body}
    fixture_hash(resource, data: bindings)
  end

  def error_response(status, error_message = nil, errors = nil)
    defaults = { "message" => "Invalid authorization credentials", "errors" => nil }
    options = defaults.merge({ "message" => error_message, "errors" => errors })

    case status
    when 401
      { status: status, body: { "type" => "authentication_error" }.merge(options).to_json }
    when 400
      { status: status, body: { "type" => "invalid_request_error" }.merge(options).to_json }
    end
  end
end

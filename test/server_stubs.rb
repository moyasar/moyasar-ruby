require 'moyasar_fixtures'

module ServerStubs
  include MoyasarFixtures

  API_URI = /api(mig)?\.moyasar\.com\/v1\/.*/

  def stub_server_request(resource, key: '', status: 200, body: {})
    case status
    when 200..201 then response = ok_response(resource, status, body)
    when 400..429 then response = error_response(status)
    end

    stub_request(:any, API_URI).with(basic_auth: [key, ''], body: body).to_return(response)
  end

  private
  def ok_response(resource, status, body)
    bindings = {status: status, body: body}
    fixture_hash(resource, data: bindings)
  end

  def error_response(status, message = nil, errors = nil)
    if status == 401
      {status: status, body: {"type"=>"authentication_error", "message"=>"Invalid authorization credentials", "errors"=>nil}.to_json}
    elsif status == 400
      {status: status, body: {"type"=>"invalid_request_error", "message"=>"Validation Failed", "errors"=>{"amount"=>["must be greater than 99"]}}.to_json }
    end
  end
end

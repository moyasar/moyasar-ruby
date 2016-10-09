require "uri"
require "net/http"
require "json"
require "ostruct"

require "moyasar/version"
require "moyasar/http_client"

require "moyasar/actions/request"
require "moyasar/actions/construct"
require "moyasar/actions/create"
require "moyasar/actions/list"
require "moyasar/actions/fetch"
require "moyasar/actions/update"

require "moyasar/source"
require "moyasar/resource"
require "moyasar/payment"
require "moyasar/invoice"

require "moyasar/sources/sadad"
require "moyasar/sources/credit_card"

require "moyasar/errors/moyasar_error"
require "moyasar/errors/authentication_error"
require "moyasar/errors/invalid_request_error"

module Moyasar
  @api_base    = "https://apimig.moyasar.com"
  @api_version = "v1"

  @client = Moyasar::HTTPClient.new(@api_base)

  Errors = {
    'authentication_error'  => Moyasar::AuthenticationError,
    'invalid_request_error' => Moyasar::InvalidRequestError,
  }

  class << self
    attr_accessor :api_key
    attr_reader :api_base, :api_version

    def request(method, url, key: nil, params: {}, headers: {})
      # TODO: handle exceptions
      unless key ||= @api_key
        raise AuthenticationError.new("No API Key provided.")
      end

      # puts method, url, key
      response = @client.request_json(method, url, key, params, headers)
      case response.code
      when 400..401 then raise Errors[response.body['type']].new(response.body.merge({'http_code' => response.code}))
      end
      response
    end

  end
end

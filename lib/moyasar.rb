require 'uri'
require 'cgi'
require 'net/http'
require 'json'

require 'moyasar/version'
require 'moyasar/http_client'

require 'moyasar/actions/request'
require 'moyasar/actions/construct'
require 'moyasar/actions/create'
require 'moyasar/actions/list'
require 'moyasar/actions/fetch'
require 'moyasar/actions/update'
require 'moyasar/actions/refund'
require 'moyasar/actions/cancel'

require 'moyasar/source'
require 'moyasar/resource'
require 'moyasar/payment'
require 'moyasar/invoice'

require 'moyasar/sources/sadad'
require 'moyasar/sources/credit_card'

require 'moyasar/errors/moyasar_error'
require 'moyasar/errors/authentication_error'
require 'moyasar/errors/invalid_request_error'
require 'moyasar/errors/account_inactive_error'
require 'moyasar/errors/rate_limit_error'
require 'moyasar/errors/api_connection_error'
require 'moyasar/errors/api_error'

module Moyasar
  @api_base    = 'https://api.moyasar.com'
  @api_version = 'v1'

  Errors = {
    'authentication_error'   => Moyasar::AuthenticationError,
    'invalid_request_error'  => Moyasar::InvalidRequestError,
    'account_inactive_error' => Moyasar::AccountInactiveError,
    'rate_limit_error'       => Moyasar::RateLimitError,
    'api_connection_error'   => Moyasar::APIConnectionError,
    'api_error'              => Moyasar::APIError,
  }.freeze

  class << self
    attr_accessor :api_key
    attr_reader :api_base, :api_version

    def request(method, url, key: nil, params: {}, headers: {})
      unless key ||= @api_key
        raise AuthenticationError.new('No API Key provided.')
      end

      client = Moyasar::HTTPClient.new(@api_base)
      response = client.request_json(method, url, key, params, headers)
      case response.code
      when 400..429
        error_data = response.body.merge({ 'http_code' => response.code })
        error = Errors[response.body['type']]
        raise error, error_data
      when 500..504
        raise APIError, { 'http_code' => response.code }
      end
      response
    end

  end
end

module Moyasar
  class HTTPClient

    METHOD_CLASS = {
      head:   Net::HTTP::Head,
      get:    Net::HTTP::Get,
      post:   Net::HTTP::Post,
      put:    Net::HTTP::Put,
      delete: Net::HTTP::Delete
    }

    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json'
    }

    def initialize(endpoint)
      uri = URI.parse(endpoint)
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true
    end

    def request(method, path, key = nil, params = {}, headers = {})
      case method
      when :get
        full_path = encode_path_params(path, params)
        request = METHOD_CLASS[method.to_sym].new(full_path, DEFAULT_HEADERS)
      else
        request = METHOD_CLASS[method.to_sym].new(path, DEFAULT_HEADERS)
        # post_data = URI.encode_www_form(params)
        request.body = params.to_json
      end

      unless key.nil?
        request.basic_auth(key, '')
      end

      @http.request(request)
    end

    def request_json(method, path, key = nil, params = {}, headers = {})
      response = request(method, path, key, params, headers)
      body = JSON.parse(response.body)

      OpenStruct.new(code: response.code.to_i, body: body)
    rescue JSON::ParserError
      response
    end

    private

    def encode_path_params(path, params)
      encoded = URI.encode_www_form(params)
      [path, encoded].join("?")
    end

  end
end

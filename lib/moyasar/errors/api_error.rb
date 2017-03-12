module Moyasar
  class APIError < MoyasarError
    def initialize(attrs = {})
      attrs['type'] ||= 'API_ERROR'
      attrs['http_code'] ||= 500
      attrs['message'] = 'We had a problem with Moyasar server.'
      super(attrs)
    end
  end
end

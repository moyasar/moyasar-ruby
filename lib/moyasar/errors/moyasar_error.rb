module Moyasar
  class MoyasarError < StandardError
    attr_reader :type, :http_code
    
    def initialize(attrs = {})
      @type = attrs['type']
      @http_code = attrs['code']
      super(attrs['message'])
    end
  end
end

module Moyasar
  class MoyasarError < StandardError
    attr_reader :type, :http_code
    
    def initialize(attrs = {})
      @type = attrs['type']
      @http_code = attrs['code']
      super(attrs['message'])
    end

    def to_s
      status_string = @http_code.nil? ? "" : "(Status #{@http_code}) "
      "#{status_string}#{@message}"
    end
  end
end

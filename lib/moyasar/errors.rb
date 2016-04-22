module Moyasar
  class MoyasarErrors < StandardError
    attr_reader :type
    attr_reader :message
    attr_reader :status
    attr_reader :json_body

    def initialize(type=nil, message=nil, status=nil, json_body=nil)
      @type = type
      @message = message
      @status = status
      @json_body = json_body
    end
    
    def to_s
      status_string = @status.nil? ? "" : "(Status #{@status}) "
      "#{status_string}#{@message}"
    end

  end
  
  class AuthenticationError < MoyasarError; end
  class APIError            < MoyasarError; end
  class APIConnectionError  < MoyasarError; end
  class RateLimitError      < MoyasarError; end
  class InvalidRequestError < MoyasarError
    attr_reader :errors
    
    def initialize(type=nil, message=nil, errors=nil, status=nil, json_body=nil)
      super(type, message, status, json_body)
      @errors = errors
    end
  end
end
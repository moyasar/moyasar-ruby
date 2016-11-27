module Moyasar
  class APIError < MoyasarError
    def initialize(message)
      super({message: message, type: 'API_ERROR', http_code: 500})
    end
  end
end

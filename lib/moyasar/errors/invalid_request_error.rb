module Moyasar
  class InvalidRequestError < MoyasarError
    attr_reader :errors

    def initialize(attrs = {})
      @errors = attrs['errors']
      super
    end
  end
end

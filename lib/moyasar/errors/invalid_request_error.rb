module Moyasar
  class InvalidRequestError < MoyasarError
    attr_reader :errors

    def initialize(attrs = {})
      @errors = attrs['errors']

      attrs['message'] = "#{attrs['message']}: #{@errors.keys.first} #{@errors.values.first.first}" if @errors.keys.count == 1
      super(attrs)
    end

  end
end

module Moyasar
  class InvalidRequestError < MoyasarError
    attr_reader :errors

    def initialize(attrs = {})
      @errors = attrs['errors']

      if @errors.respond_to?(:keys) && @errors.keys.count > 0
        attrs['message'] = "#{attrs['message']}: #{@errors.keys.first} #{@errors.values.first.first}"
      end
      super(attrs)
    end

  end
end

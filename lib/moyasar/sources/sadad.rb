module Moyasar
  class Sadad < Source
    attr_reader :username, :error_code, :message, :transaction_url, :transaction_id

    def ==(other)
      return unless other.instance_of? Sadad
      [:username, :error_code, :message, :transaction_url, :transaction_id].all? { |attr| self.send(attr) == other.send(attr) }
    end
  end
end

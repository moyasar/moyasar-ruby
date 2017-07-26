module Moyasar
  class CreditCard < Source
    attr_reader :company, :name, :number, :message, :transaction_url

    def ==(other)
      return unless other.instance_of? CreditCard
      [:company, :name, :number, :message].all? { |attr| self.send(attr) == other.send(attr) }
    end
  end
end

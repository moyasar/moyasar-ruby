module Moyasar
  class STCPay < Source
    attr_reader :mobile, :reference_number, :branch, :cashier, :reference_number, :message, :transaction_url

    def ==(other)
      return unless other.instance_of? STCPay
      [:mobile, :reference_number, :branch, :cashier, :reference_number, :transaction_url, :message].all? { |attr| self.send(attr) == other.send(attr) }
    end
  end
end

module Moyasar
  class ApplePay < Source
    attr_reader :company, :name, :number, :gateway_id, :reference_number, :message

    def ==(other)
      return unless other.instance_of? ApplePay
      [:company, :name, :number, :message].all? { |attr| self.send(attr) == other.send(attr) }
    end
  end
end

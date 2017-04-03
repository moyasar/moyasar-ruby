module Moyasar
  class Invoice < Resource
    attr_reader :id, :status, :amount_format, :url, :payments, :created_at, :updated_at
    attr_accessor :description, :amount, :currency

    def ==(other)
      return false unless other.is_a? Invoice

      [:id, :status, :description, :amount, :currency,  :url, :created_at, :updated_at].all? do |attr|
        self.send(attr) == other.send(attr)
      end
    end

    alias to_s inspect
  end
end

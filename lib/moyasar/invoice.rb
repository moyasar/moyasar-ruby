module Moyasar
  class Invoice < Resource

    attr_reader :id, :status, :created_at, :modified_at
    attr_accessor :description, :amount, :currency

  end
end

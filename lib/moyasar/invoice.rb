module Moyasar
  class Invoice < Resource
    attr_reader :id, :status, :amount_format, :url, :created_at, :updated_at
    attr_accessor :description, :amount, :currency
  end
end

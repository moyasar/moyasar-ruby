module Moyasar
  class Payment < Resource
    include Moyasar::Actions::Refund

    attr_reader :id, :status, :amount, :amount_format, :fee, :fee_format, :currency, :invoice_id,
                :source, :refunded, :refunded_at, :ip, :created_at, :updated_at
    attr_accessor :description

    def initialize(attrs = {})
      source  = attrs.delete('source')
      type    = source.delete('type')
      @source = Moyasar::Source.build(type, source)

      super
    end

    def ==(other)
      return false unless other.is_a? Payment

      [:id, :status, :amount, :fee, :currency, :invoice_id, :source, :refunded, :refunded_at, :ip, :created_at, :updated_at].all? do |attr|
        self.send(attr) == other.send(attr)
      end
    end

    alias to_s inspect

    class << self

      def create(source:, amount:, currency: 'SAR', description: nil)
        params = {amount: amount, currency: currency, description: description, source: source}
        super(params)
      end

    end

  end
end

module Moyasar
  class Payment < Resource
    attr_reader :id, :status, :amount, :amount_format, :fee, :fee_format, :currency, :invoice_id,
                :refunded, :refunded_at, :ip, :created_at, :updated_at, :source
    attr_accessor :description

    def initialize(attrs = {})
      source  = attrs.delete('source')
      type    = source.delete('type')
      @source = Moyasar::Source.build(type, source)

      super
    end

    # TODO == should work between payments

    class << self

      def create(source:, amount:, currency: 'SAR', description: nil)
        params = {amount: amount, currency: currency, description: description, source: source}
        super(params)
      end

    end

  end
end

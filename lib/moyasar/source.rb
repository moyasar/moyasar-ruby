module Moyasar
  class Source
    include Moyasar::Actions::Construct

    class << self
      def build(type, attrs = {})
        sources = {
          'sadad'      => Sadad,
          'creditcard' => CreditCard
        }

        sources[type].new(attrs)
      end
      # private new
    end

  end
end

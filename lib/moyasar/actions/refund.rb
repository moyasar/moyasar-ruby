module Moyasar
  module Actions
    module Refund

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def refund(id, attrs = {})
          response = request(:post, refund_url(id), params: attrs)

          new(response.body)
        end
      end

      module InstanceMethods
      end

    end
  end
end

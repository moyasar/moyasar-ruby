module Moyasar
  module Actions
    module Refund

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def refund(id, attrs = {})
          perform_refund(id, attrs)
        end

        def perform_refund(id, attrs = {})
          response = request(:post, refund_url(id), params: attrs)
          new(response.body)
        end
      end

      module InstanceMethods
        def refund(attrs = {})
          self.class.perform_refund(id, attrs) unless id.nil?
        end
      end

    end
  end
end

module Moyasar
  module Actions
    module Cancel

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def cancel(id)
          perform_cancel(id)
        end

        def perform_cancel(id)
          response = request(:put, cancel_url(id))
          new(response.body)
        end
      end

      module InstanceMethods
        def cancel()
          self.class.perform_cancel(id) unless id.nil?
        end
      end
    end
  end
end

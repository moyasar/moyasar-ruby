module Moyasar
  module Actions
    module Capture
      
      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def capture(id, attrs = {})
          perform_capture(id, attrs)
        end

        def perform_capture(id, attrs = {})
          response = request(:post, capture_url(id), params: attrs)
          new(response.body)
        end
      end
      
      module InstanceMethods
        def capture(attrs = {})
          self.class.perform_capture(id, attrs) unless id.nil?
        end
      end

    end
  end
end
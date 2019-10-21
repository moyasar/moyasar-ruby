module Moyasar
  module Actions
    module Void
      
      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def void(id)
          perform_void(id)
        end

        def perform_void(id)
          response = request(:post, void_url(id))
          new(response.body)
        end
      end
      
      module InstanceMethods
        def void
          self.class.perform_void(id) unless id.nil?
        end
      end

    end
  end
end
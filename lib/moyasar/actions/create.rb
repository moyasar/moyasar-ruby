module Moyasar
  module Actions
    module Create

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def create(attrs = {})
          response = request(:post, create_url, params: attrs)

          new(response.body)
        end
      end

      module InstanceMethods
      end

    end    
  end
end
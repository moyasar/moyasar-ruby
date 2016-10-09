module Moyasar
  module Actions
    module List

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        # TODO should accept pagination and query options
        def list(attrs = {})
          response = request(:get, list_url, params: attrs)
          response.body[resource_name].map {|resource| new(resource)}
        end
        alias all list
      end

      module InstanceMethods
      end

    end    
  end
end
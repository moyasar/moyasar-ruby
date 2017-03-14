module Moyasar
  module Actions
    module Fetch

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
        def fetch(id)
          response = request(:get, find_url(id))
          new(response.body)
        end
        alias find fetch
      end

      module InstanceMethods
      end

    end
  end
end

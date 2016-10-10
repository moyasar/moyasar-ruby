module Moyasar
  module Actions
    module Update

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
      end

      module ClassMethods
      end

      module InstanceMethods

        def update(attrs = {})
          response = request(:put, update_url(id), params: attrs)

          if response.code.to_i == 200
            true
          else
            false
          end
        end

      end

    end
  end
end

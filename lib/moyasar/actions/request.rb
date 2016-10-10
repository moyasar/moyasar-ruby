module Moyasar
  module Actions
    module Request

      def self.included(klass)
        klass.extend Request
      end

      def request(method, url, params: {}, headers: {})
        Moyasar.request(method, url, params: params, headers: headers)
      end

    end
  end
end

module Moyasar
  module Actions
    module Request

      def self.included cls
        cls.extend Request
      end

      def request(method, url, params: {}, headers: {})
        Moyasar.request(method, url, params: params, headers: headers)
      end

    end
  end
end
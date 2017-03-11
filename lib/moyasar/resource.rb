module Moyasar
  class Resource
    include Moyasar::Actions::Request
    include Moyasar::Actions::Construct
    include Moyasar::Actions::Create
    include Moyasar::Actions::List
    include Moyasar::Actions::Fetch
    include Moyasar::Actions::Update

    class << self

      def class_name
        name.split('::')[-1]
      end

      def resource_name
        "#{class_name.downcase}s"
      end

      def resource_url
        if self == Resource
          raise NotImplementedError.new('Resource is an abstract class. You should perform actions on its subclasses (Payment, Invoice, etc.)')
        end
        "/#{Moyasar.api_version}/#{CGI.escape(resource_name)}"
      end

      private

      def create_url
        resource_url
      end

      def list_url
        create_url
      end

      def find_url(id)
        "#{resource_url}/#{id}"
      end

      def refund_url(id)
        "#{resource_url}/#{id}/refund"
      end

    end

    private

    def update_url(id)
      "#{self.class.resource_url}/#{id}"
    end

  end
end

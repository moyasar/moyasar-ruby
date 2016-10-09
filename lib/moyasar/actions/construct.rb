module Moyasar
  module Actions
    module Construct

      def self.included(klass)
        klass.extend         ClassMethods
        klass.send :include, InstanceMethods
        klass.send :prepend, Initializer
      end

      module ClassMethods        
      end
  
      module InstanceMethods

        def construct(attrs = {})
          attrs.each do |key, value|
            self.instance_variable_set("@#{key}".to_sym, value)
          end
        end

      end
      
      module Initializer
        def initialize(attrs = {})
          # puts "construct ...#{self}  #{attrs}"
          construct(attrs)
          super()
        end
      end

    end    
  end
end
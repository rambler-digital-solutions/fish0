module Fish0
  module Concerns
    module ViewModel
      extend ActiveSupport::Concern

      included do
        extend Dry::Struct::ClassInterface

        constructor_type(:permissive)

        def initialize(attributes)
          attributes.each { |key, value| instance_variable_set("@#{key}", value) }
        end

        def [](name)
          public_send(name)
        end

        def to_hash
          self.class.schema.keys.each_with_object({}) do |key, result|
            result[key] = Hashify[self[key]]
          end
        end
        alias_method :to_h, :to_hash

        attribute :type, String

        def type
          (super || '').demodulize.underscore
        end

        def to_partial_path
          type.to_s
        end
      end
    end
  end
end

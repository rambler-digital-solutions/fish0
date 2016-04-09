module Fish0
  module Concerns
    module Base
      extend ActiveSupport::Concern

      cattr_accessor :primary_key, instance_writer: false

      def primary_key
        self.class.primary_key
      end

      def primary_key_value
        send(primary_key)
      end

      included do
        class << self
          def primary_key(val = @@primary_key)
            @@primary_key = val
            return default_primary_key unless @@primary_key
            @@primary_key
          end

          def cacheable
            include Concerns::Cacheable
          end

          delegate :all, to: :repository
          delegate :where, to: :repository
          delegate :first, to: :repository
          delegate :last, to: :repository
          delegate :search, to: :repository
          delegate :order_by, to: :repository
          delegate :limit, to: :repository
          delegate :skip, to: :repository
          delegate :projection, to: :repository

          def first!
            first || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
          end

          def last!
            last || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
          end

          private

          def default_primary_key
            :slug
          end

          def entity
            self
          end

          def collection
            model_name.collection
          end

          def repository
            Fish0::Repository.new(collection, entity)
          end
        end
      end
    end
  end
end

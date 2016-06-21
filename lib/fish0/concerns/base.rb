module Fish0
  module Concerns
    module Base
      extend ActiveSupport::Concern

      def primary_key
        self.class.primary_key
      end

      def primary_key_value
        send(primary_key)
      end

      included do
        class << self
          def primary_key(val = @primary_key)
            @primary_key = val
            return default_primary_key unless @primary_key
            @primary_key
          end

          def cacheable
            include Concerns::Cacheable
          end

          def method_missing(method_name, *arguments, &block)
            if repository.respond_to?(method_name)
              repository.send(method_name, *arguments, &block)
            else
              super
            end
          end

          def respond_to_missing?(method_name, include_private = false)
            repository.respond_to?(method_name) || super
          end

          protected

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
            if "#{entity}Repository".safe_constantize
              return "#{entity}Repository".constantize.new(collection, entity)
            end
            Fish0::Repository.new(collection, entity)
          end
        end
      end
    end
  end
end

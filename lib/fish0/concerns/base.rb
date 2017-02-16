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

          def disable_coercion
            include Virtus.model(coerce: false)
          end
          alias_method :skip_coercion, :disable_coercion # DEPRECATED

          def enable_coercion
            include Virtus.model(coerce: true)
          end

          def scope(name, body)
            scopes << [name, body]
          end

          def scopes
            @scopes ||= []
          end

          # rubocop:disable Style/TrivialAccessors
          def default_scope(body)
            @default_scope = body
          end
          # rubocop:enable Style/TrivialAccessors

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
            rep = repository_class.new(collection: collection, entity_class: entity)
            rep.instance_exec(&@default_scope) if @default_scope
            scopes.each { |s| rep.scope(*s) }
            rep
          end

          def repository_class
            return "#{entity}Repository".constantize if "#{entity}Repository".safe_constantize
            Fish0::Repository
          end
        end
      end
    end
  end
end

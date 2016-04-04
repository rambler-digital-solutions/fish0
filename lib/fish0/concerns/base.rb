module Fish0
  module Concerns
    module Base
      extend ActiveSupport::Concern

      included do
        class << self
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

          def collection
            name.tableize
          end

          def repository
            Fish0::Repository.new(collection)
          end
        end
      end
    end
  end
end

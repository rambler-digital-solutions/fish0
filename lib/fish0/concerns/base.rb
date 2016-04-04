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

module Fish0
  module Concerns
    module ViewModel
      extend ActiveSupport::Concern

      included do
        include Virtus::Model
        attribute :type, String

        def type
          (super || '').demodulize.underscore
        end

        def to_partial_path
          "#{type}"
        end
      end
    end
  end
end

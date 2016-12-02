module Fish0
  class Model < Dry::Struct
    extend ActiveModel::Naming
    include Fish0::Concerns::Base
    include Fish0::Concerns::Equalable

    attribute :type, Types::Coercible::String

    def type
      (super || '').demodulize.underscore
    end

    def to_partial_path
      type.to_s
    end
  end
end

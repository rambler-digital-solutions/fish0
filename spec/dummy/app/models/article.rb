# class Article < Fish0::Model
#   attribute :slug, Fish0::Types::Coercible::String
#   attribute :headline, Fish0::Types::Coercible::String
#   attribute :content, Fish0::Types::Coercible::String
# end
class Article < Dry::Struct
  attribute :slug, Fish0::Types::String.optional
  attribute :headline, Fish0::Types::String.optional
  attribute :content, Fish0::Types::String.optional
end

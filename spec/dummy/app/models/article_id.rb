class ArticleId < Fish0::Model
  attribute :id, Integer
  attribute :headline, String
  attribute :content, String

  primary_key :id
end

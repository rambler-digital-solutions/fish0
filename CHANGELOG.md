## Fish0 0.0.17 (November 30, 2016) ##

* Add `scope` method to `Fish0::Base` concern and to `Fish0::Repository` instance.

```ruby
class Topic < Fish0::Model
  attribute :id, Integer
  attribute :published_at, DateTime

  scope :by_id, -> (id) { where(id: id) }
end

Topic.by_id(15) # => #<Fish0::Repository ... @conditions={:id=>15} ...>
Topic.order_by(published_at: -1).by_id(15) # => #<Fish0::Repository ... @conditions={:id=>15}, @order={:published_at=>-1} ...>
```

## Fish0 0.0.16 (September 5, 2016) ##

* Generate collection `.cache_key` from `.primary_key_value` instead of `:slug`

## Fish0 0.0.15 (September 5, 2016) ##

* `Fish0::Repository#all` now returns self instead of collection.
For collection please use `Fish0::Repository#to_collection`.

* Fixes in `Paginator`.

* Now Rails 5 compatible.

## Fish0 0.1.2 (February, 16, 2017) ##

* `Fish0::Repository` now initializes with keyword arguments, not positional!
* Added `source` argument to `Fish0::Repository` to allow use different sources

## Fish0 0.1.1 (February, 16, 2017) ##

* CRASHES! DO NOT USE!

## Fish0 0.1.0 (February, 01, 2017) ##

* Rename `skip_coercion` method to `disable_coercion` in `Fish0::Base` concern
* Add `enable_coercion` method to `Fish0::Base` concern
* Skip coercion in `Fish0::Model` by default

## Fish0 0.0.18 (December 02, 2016) ##

* Add `default_scope` method to `Fish0::Base` concern
* Fix scopes issue

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

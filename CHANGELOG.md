## Fish0 0.0.16 (September 5, 2016) ##

* Generate collection `.cache_key` from `.primary_key_value` instead of `:slug`

## Fish0 0.0.15 (September 5, 2016) ##

* `Fish0::Repository#all` now returns self instead of collection.
For collection please use `Fish0::Repository#to_collection`.

* Fixes in `Paginator`.

* Now Rails 5 compatible.

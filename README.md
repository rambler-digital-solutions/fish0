# Fish0

> The fish doesn't think because the fish knows everything.

Fish0 is the plugin for read-only content websites with MongoDB storage. Works perfect with Rambler&Co CQRS architecture.

## Installation

Simply add gem to your `Gemfile`

````
gem 'fish0'
````

## Configuration

```yml
# config/mongo.yml

development:
  hosts:
    - 'localhost:27017'
  params:
    :database: project_development

production:
  hosts:
    - 'db.project.tld:27017'
  params:
    :database: project_production
```

## Models

Inherit your model class from `Fish0::Model` and feel the power of the Fish!

With `attribute` define your attributes and with `primary_key` set your main primary key, e.g. `id`, `slug`, etc.
```ruby
# app/models/article.rb
class Article < Fish0::Model
  # Define some attributes
  attribute :headline, String
  attribute :slug, String
  attribute :content, Array[Hash]
  attribute :published_at, DateTime

  primary_key :slug

  # ...
end

# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  # ...

  def show
    @article = Article.where(slug: params[:slug]).first
  end

  # ...
end
```

## Repository

### Basic repository usage

This code will get first article with `slug: 'content123'` from `articles` MongoDB collection, and return content with class `Article`.

```ruby
Fish0::Repository.new(:articles)
                 .where(slug: 'content123')
                 .first!
```

By default Fish0::Repository will coerce `:entity_class` from `:collection`, so you can skip this parameter.

### Writing your own repository

```ruby
# app/services/article_repository.rb
class ArticleRepository < Fish0::Repository
  def initialize
    super(:articles)
  end

  def published
    where(visible: true, published_at: { '$lt': DateTime.now })
  end
end

# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  # ...

  def show
    @article = ArticleRepository.new.where(slug: params[:slug]).first!
  end

  # ...
end
```

## Pagination

```ruby
# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  include Fish0::Concerns::Paginatable

  def index
    @articles = paginate(ArticleRepository.new.published)
  end

  # ...

  protected

  def per_page
    31
  end

  # ...
end
```

## ViewModel

ViewModel concern wraps Virtus around your models. It also adds `#to_partial_path` and `#type` methods. Method `#to_partial_path` helps render your models via `render` helper.


```ruby
# app/models/article.rb
class Article
  include Fish0::Concerns::ViewModel

  attribute :headline, String
  attribute :slug, String
  attribute :content, Array[Hash]
  attribute :published_at, DateTime

  # ...
end
```

## Cacheable

If you want your models to support `#cache_key` method and use Rails caching, you should include Fish0::Concerns::Cacheable to such models.

Your model should respond to `:updated_at` with DateTime object.

```ruby
# app/models/article.rb
class Article
  # ...
  include Fish0::Concerns::Cacheable

  # ...
end

# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  # ...

  def show
    @article = ArticleRepository.new.where(slug: params[:slug]).first!
    if stale?(@article)
      respond_to do |format|
        format.html
      end
    end
  end

  # ...
end
```

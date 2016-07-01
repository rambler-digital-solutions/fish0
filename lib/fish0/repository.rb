module Fish0
  class Repository
    attr_reader :source,
                :collection,
                :conditions,
                :order,
                :skip_quantity,
                :limit_quantity,
                :entity_class

    include Enumerable

    delegate :find, :aggregate, :distinct, to: :source
    delegate :each, to: :all

    def initialize(collection, entity_class = nil)
      raise ArgumentError, 'you should provide collection name' unless collection
      @collection = collection
      @source = Fish0.mongo_reader[collection]
      @conditions = default_conditions
      @order = {}
      @limit_quantity = 0
      @skip_quantity = 0
      @entity_class = entity_class || String(collection).singularize.camelize.constantize
    end

    def all
      Fish0::Collection.new(fetch.map(&to_entity))
    end

    def projection(values)
      @projection = values
      self
    end

    def first
      element = fetch.limit(1).first
      to_entity.call(element) if element
    end

    def first!
      first || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
    end

    def last
      element = all.last
      to_entity.call(element) if element
    end

    def last!
      last || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
    end

    def where(query)
      conditions.merge!(query)
      self
    end

    def search(string)
      where('$text' => { '$search' => string })
      self
    end

    def order_by(query)
      order.merge!(query)
      self
    end

    def limit(value)
      @limit_quantity = value
      self
    end

    def skip(value)
      @skip_quantity = value
      self
    end

    def fetch
      scoped = find(conditions, sort: order)
      scoped = scoped.projection(@projection) if @projection
      scoped = scoped.skip(skip_quantity) if skip_quantity > 0
      scoped = scoped.limit(limit_quantity) if limit_quantity > 0
      scoped
    end

    def count
      find(conditions).count
    end

    protected

    def default_conditions
      {}
    end

    def to_entity
      -> (attrs) { entity_class.new(attrs) }
    end
  end
end

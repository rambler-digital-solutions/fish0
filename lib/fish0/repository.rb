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

    delegate :aggregate, to: :source
    delegate :each, to: :to_collection

    def initialize(collection:, entity_class: nil, source: nil)
      raise ArgumentError, 'you should provide collection name' unless collection
      @collection = collection
      @source = source ? source[collection] : Fish0.mongo_reader[collection]
      @conditions = default_conditions
      @order = {}
      @limit_quantity = 0
      @skip_quantity = 0
      @hint = nil
      @entity_class = entity_class || String(collection).singularize.camelize.constantize
    end

    def find_one(query)
      where(query).first
    end

    def find_one!(query)
      find_one(query) || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
    end

    def to_collection
      Fish0::Collection.new(fetch.map(&to_entity))
    end

    def find(filter = nil, options = {})
      @source.find filter.dup, options
    end

    def all
      self
    end

    def projection(values)
      @projection = values
      self
    end

    def distinct(field)
      @source.distinct field, @conditions
    end

    def first
      element = fetch.limit(1).first
      to_entity.call(element) if element
    end

    def first!
      first || raise(RecordNotFound, "can't find in #{collection} with #{conditions}")
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

    def hint(value)
      @hint = value
      self
    end

    def scope(name, body)
      return if respond_to?(name)

      unless body.respond_to?(:call)
        raise ArgumentError, 'The scope body needs to be callable.'
      end

      define_singleton_method(name) do |*args|
        instance_exec(*args, &body)
        self
      end
    end

    def fetch
      scoped = find(conditions, sort: order)
      scoped = scoped.projection(@projection) if @projection
      scoped = scoped.skip(skip_quantity) if skip_quantity.positive?
      scoped = scoped.limit(limit_quantity) if limit_quantity.positive?
      scoped = scoped.hint(@hint) if @hint
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

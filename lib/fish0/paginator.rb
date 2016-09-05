module Fish0
  class Paginator
    include Enumerable
    delegate :each, :to_collection, :skip, :limit, :padding, :fetch, to: :collection

    attr_reader :collection

    def initialize(collection, page_number: 1, per_page: 22, padding: 0)
      raise ArgumentError,
            'you can paginate only Fish0::Repository' unless collection.is_a?(Fish0::Repository)
      @collection = collection
      @per = per_page
      @page = page_number
      @padding = padding
      per(per_page)
      page(page_number)
    end

    def page(value = @page)
      @page = value
      skip((@page - 1) * @per + @padding)
      self
    end

    def per(value = @per)
      @per = value
      skip((@page - 1) * @per + @padding)
      limit(@per)
      self
    end

    def padding(value)
      @padding = value
      page
      skip
      self
    end

    def total
      collection.count
    end

    def current_page
      @page
    end

    def pages
      (total.to_f / @per).ceil
    end

    def last_page?
      current_page >= pages
    end
  end
end

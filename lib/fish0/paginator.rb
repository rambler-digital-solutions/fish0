module Fish0
  class Paginator
    include Enumerable
    delegate :each, :all, :skip, :limit, :padding, to: :collection

    attr_reader :collection

    def initialize(collection, page_number: 1, per_page: 22, padding: 0)
      @collection = collection || (raise ArgumentError)
      @per = per_page
      @page = page_number - 1
      @padding = padding
      per(per_page)
      page(page_number)
    end

    def page(value = @page)
      @page = value
      skip(@page * @per + @padding)
      self
    end

    def per(value = @per)
      @per = value
      skip(@page * @per + @padding)
      limit(@per)
      self
    end

    def padding(value)
      @padding = value
      page
      skip
      self
    end
  end
end

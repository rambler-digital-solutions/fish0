module Fish0
  module Concerns
    module Paginatable
      extend ActiveSupport::Concern

      included do
        helper_method :page

        protected

        def page
          @page ||= (params[:page].to_i || 1)
        end

        def paginate(collection)
          Fish0::Paginator.new(collection, page_number: page, per_page: per_page).to_collection
        end

        def per_page
          22
        end
      end
    end
  end
end

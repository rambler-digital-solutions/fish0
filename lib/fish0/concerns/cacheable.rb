module Fish0
  module Concerns
    module Cacheable
      extend ActiveSupport::Concern

      included do
        def cache_key(*timestamp_names)
          case
          when timestamp_names.any?
            timestamp = max_updated_column_timestamp(timestamp_names)
            timestamp = timestamp.utc.to_s(:nsec)
            "#{self.class.to_s.tableize}/#{slug}-#{timestamp}"
          when timestamp = max_updated_column_timestamp
            timestamp = timestamp.utc.to_s(:nsec)
            "#{self.class.to_s.tableize}/#{slug}-#{timestamp}"
          else
            "#{self.class.to_s.tableize}/#{slug}"
          end
        end

        private

        def timestamp_attributes_for_update
          [:updated_at]
        end

        def max_updated_column_timestamp(timestamp_names = timestamp_attributes_for_update)
          timestamp_names
            .map { |attr| self[attr] }
            .compact
            .map(&:to_time)
            .max
        end
      end
    end
  end
end

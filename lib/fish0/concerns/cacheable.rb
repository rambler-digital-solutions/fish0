module Fish0
  module Concerns
    module Cacheable
      extend ActiveSupport::Concern

      included do
        def cache_key(*timestamp_names)
          if timestamp_names.any?
            timestamp = max_updated_column_timestamp(timestamp_names)
            "#{self.class.to_s.tableize}/#{primary_key_value}-#{timestamp.utc.to_s(:nsec)}"
          elsif timestamp = max_updated_column_timestamp
            "#{self.class.to_s.tableize}/#{primary_key_value}-#{timestamp.utc.to_s(:nsec)}"
          else
            "#{self.class.to_s.tableize}/#{primary_key_value}"
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

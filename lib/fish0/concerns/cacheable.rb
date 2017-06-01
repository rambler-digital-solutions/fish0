module Fish0
  module Concerns
    module Cacheable
      extend ActiveSupport::Concern

      included do
        def cache_key(*timestamp_names)
          if timestamp_names.any?
            cache_key_string(max_updated_column_timestamp(timestamp_names))
          elsif (timestamp = max_updated_column_timestamp)
            cache_key_string(timestamp)
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

        def cache_key_string(timestamp)
          "#{self.class.to_s.tableize}/#{primary_key_value}-#{timestamp.utc.to_s(:nsec)}"
        end
      end
    end
  end
end

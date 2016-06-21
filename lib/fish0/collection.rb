module Fish0
  class Collection < Array
    def cache_key
      most_recent = select(&:updated_at).sort_by(&:updated_at).last

      timestamp = time_to_string(most_recent ? most_recent.updated_at : Time.zone.now)

      "#{objects_key}-#{timestamp}"
    end

    protected

    def objects_key
      Digest::MD5.hexdigest(map(&:slug).join)
    end

    def time_to_string(timestamp)
      timestamp.strftime('%Y%m%d%H%M%S%9N')
    end
  end
end

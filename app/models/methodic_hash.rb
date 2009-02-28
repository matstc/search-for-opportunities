class MethodicHash 
    DATE_FORMAT = "%Y/%m/%d %H:%M:%S %z"

    def initialize(hash={})
        @hash = hash
    end

    def friendly_creation_date
        #not specifying date format here cause the heuristics just work
        date = Date.parse(created_at) rescue nil
        return nil if date.blank?

        today = Date.today

        return "today" if date == today
        return "yesterday" if date == (today - 1)
        return "#{today - date} days ago"
    end

    def method_missing(name, *args)
        value = @hash[name] || @hash[name.to_s]
        return MethodicHash.new value if value.is_a? Hash
        return value
    end
end

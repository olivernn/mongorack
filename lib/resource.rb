module MongoRack
  class Resource

    attr_reader :attributes

    def initialize(row)
      @row = row
      @attributes = @row
      add_attributes
    end

    def to_json
      # add_attributes
      JSON.generate @attributes
    end

    private

    def add_attributes
      self.private_methods(false).each do |method|
        if method.match /^set_\w+$/
          send method.to_sym
        end
      end
    end

    def set_id
      @attributes[:_id] = @row["_id"].to_s
      @attributes.delete("_id")
    end

    def set_created_at
      @attributes[:created_at] = @row["_id"].generation_time
    end

  end
end
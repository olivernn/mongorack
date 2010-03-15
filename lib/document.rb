module MongoRack
  class Document
    def initialize(body)
      if body.is_a? String
        from_string body  
      else
        from_hash body
      end
    end

    def to_hash
      @body
    end

    private

    def from_string(body)
      @body = JSON.parse(body)
    end

    def from_hash(body)
      @body = body
    end

    def extract_revision
      @revision = @body.delete("_rev")
    end

    def generate_meta
      @meta = {
        :updated_at => Time.now,
        :owner => 2
      }
    end
  end
end
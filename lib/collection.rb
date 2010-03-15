module MongoRack
  class Collection
    def initialize(name, db)
      @name = name
      @db = db
      @col = @db[@name]
    end

    def self.save(document)
      
    end

  end
end
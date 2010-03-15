module MongoRack
  class Service
    def initialize(app, options)
      @app = app
      @collections = options[:collections]
      @db = options[:db]
    end

    def call(env)
      request = MongoRack::Request.new(env)
      if bypass? request
        @app.call(env)
      else
        send(request.request_method.downcase, request)
      end
    end

    private

    def bypass?(request)
      @collections.include? request.collection
    end

    def get(request)
      coll = @db[request.collection]
      rows = []
      coll.find.each { |row| rows << MongoRack::Resource.new(row).attributes }
      [
        200, 
        {"Content-Length" => JSON.generate(rows).length.to_s, "Content-Type" => "application/json"},
        JSON.generate(rows)
      ]
    end

    def post(request)
      # document = Document.new(request.json).to_hash
      resource = MongoRack::Resource.new(request.json)
      id = @db[request.collection].insert(resource.attributes)
      # id = @db[request.collection].insert(document)
      document[:_id] = id.to_s
      document[:created_at] = id.generation_time
      [ 
        201, 
        {"Content-Length" => JSON.generate(document).length.to_s, "Content-Type" => "application/json"}, 
        JSON.generate(document)
      ]
    end
  end
end
module MongoRack
  class Request < Rack::Request
    def initialize(env)
      super(env)
    end

    def collection
      self.path_info.split('/')[1]
    end

    def json
      self.body.rewind
      self.body.read
    end
  end
end
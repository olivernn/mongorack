require 'rubygems'
require 'rack'
require 'json'
require 'mongo'
require 'lib/mongo_rack'
require 'lib/request'
require 'lib/document'
require 'lib/resource'

use MongoRack::Service, :collections => [:notes], :db => Mongo::Connection.new.db("mydb")
run lambda { |env| 
  [404, {'Content-Length' => '9', 'Content-Type' => 'text/plain'}, "Not Found"]
}
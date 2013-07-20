require 'rubygems'
#require 'sinatra'
require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite3:test.db');

class Message
  include DataMapper::Resource

  storage_names[:Message] = 'Message'

property :Id, Serial
property :Body, Text
end

DataMapper.finalize

puts Message.get(1).inspect
puts Message.get(1).Body

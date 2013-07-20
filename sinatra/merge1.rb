require 'rubygems'
#require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/test.db")

class Person
  include DataMapper::Resource

  property :id,  Serial
  property :first, Text
end

DataMapper.auto_upgrade!

puts Person.all.count

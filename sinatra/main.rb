require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Contact
  include DataMapper::Resource

  property :id,          Serial
  property :first,       Text
  property :last,        Text
  property :age,         Integer
  property :rating,      Integer
  property :csid,        Text
  property :telephone,   Text
  property :email,       Text
  property :notes1,       Text
  property :notes2,       Text
end

DataMapper.auto_upgrade!

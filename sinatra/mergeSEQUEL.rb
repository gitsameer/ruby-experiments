require 'rubygems'
require "sequel"

DB = Sequel.connect('sqlite://test.db')

class Message < Sequel::Model(:Message)
end

puts Message.all.inspect

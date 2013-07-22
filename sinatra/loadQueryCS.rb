require 'sequel'
require 'logger'

DB = Sequel.connect('sqlite://cs.db')

#DB.logger = Logger.new($stdout)

class Contacts < Sequel::Model(:contacts) 
end

##### Begin Queries here

puts Contacts.find(:current => true).length

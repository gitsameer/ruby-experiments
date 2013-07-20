require 'rubygems'
#require 'sinatra'
require 'active_record'

ActiveRecord::Base.configurations["db1"] = {
  :adapter => 'sqlite3',
  :database => 'test.db'
}

class Person < ActiveRecord::Base
 self.table_name = 'Message'
 establish_connection "db1"
end


=begin
Message.establish_connection(
   :adapter => "sqlite3",
   :database => "test.db"
)

=end

puts Person.all.count


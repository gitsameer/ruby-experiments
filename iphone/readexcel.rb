require 'spreadsheet'
require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter   => 'sqlite3',
   :database  => 'mergedcontacts.db'
)

class User < ActiveRecord::Base
belongs_to :place
has_many :messages
end
class Place < ActiveRecord::Base
has_many :users
end

class Message < ActiveRecord::Base
belongs_to :user
end

Users = []
Users << User.create(:first => 'f1', :last => 'l1', :phone => '123214', :rating => 4);
Users << User.create(:first => 'f2', :last => 'l2', :phone => '123214', :rating => 4);
Users << User.create(:first => 'f3', :last => 'l3', :phone => '123214', :rating => 4);

puts Users

=begin
Users = []
Spreadsheet.open('/Users/sameersingh/Documents/Personal/Travel/CouchStatsNew.xls') do |book|
  book.worksheets.each do |sheet|
    cityname = sheet.name
    sheet.each do |row|
        puts row[2] 
        puts row[3] 
	puts row[4] 
        puts row[5] 
        Users << User.create(:first => row[2], :last => row[3], :phone => row[5], :rating => row[4])
    end
  end
end

puts Users
=end

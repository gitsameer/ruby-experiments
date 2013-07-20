require 'rubygems'
require 'active_record'
require 'logger'
require 'spreadsheet'

ActiveRecord::Base.logger = Logger.new(STDERR);

ActiveRecord::Base.configurations["db1"] = {
  :adapter => 'sqlite3',
  :database => 'sms.db'
}

ActiveRecord::Base.configurations["db2"] = {
  :adapter => 'sqlite3',
  :database => 'AddressBook.sqlitedb'
}

ActiveRecord::Base.configurations["db3"] = {
  :adapter => 'sqlite3',
  :database => 'mergedcontacts.db'
}

class MessageSource < ActiveRecord::Base
  self.table_name = 'message'
  establish_connection "db1"
end

class ABPerson < ActiveRecord::Base
  self.table_name = 'ABPerson'
  establish_connection "db2"
end


class User < ActiveRecord::Base
belongs_to :place
has_many :messages
  establish_connection "db3"
end

class Place < ActiveRecord::Base
has_many :users
  establish_connection "db3"
end

class Message < ActiveRecord::Base
belongs_to :user
 establish_connection "db3"
end

############ read all person records 
a = ABPerson.first.First
puts a
#instance_variables.@columns_hash('first').value

temp_sql = "select ABPerson.ROWID, ABPerson.prefix, ABPerson.first,ABPerson.last, c.value as MobilePhone, h.value as HomePhone, he.value as HomeEmail, w.value as WorkPhone, we.value as WorkEmail from ABPerson left outer join ABMultiValue c on c.record_id = ABPerson.ROWID and c.label = 1 and c.property= 3 left outer join ABMultiValue h on h.record_id = ABPerson.ROWID and h.label = 2 and h.property = 3 left outer join ABMultiValue he on he.record_id = ABPerson.ROWID and he.label = 2 and he.property = 4 left outer join ABMultiValue w on w.record_id = ABPerson.ROWID and w.label = 4 and w.property = 3 left outer join ABMultiValue we on we.record_id = ABPerson.ROWID and we.label = 4 and we.property = 4"
result = ABPerson.connection.execute(temp_sql)

mobileNumbers = Hash.new
homeNumbers = Hash.new
workNumbers = Hash.new
workEmails = Hash.new
homeEmails = Hash.new

result.each do |r|
 #puts r.first, r.last, r.WorkPhone, r.WorkEmail, r.HomePhone, r.MobilePhone, r.HomeEmail
  name = [r['First'],r['Last'],r['ROWID']]
  if r['MobilePhone'] != nil && r['MobilePhone'].length > 0 
    mobileNumbers[r['MobilePhone']] = name
  end

  if r['HomePhone'] != nil && r['HomePhone'].length > 0 
    homeNumbers[r['HomePhone']] = name
  end

  if r['WorkPhone'] != nil && r['WorkPhone'].length > 0 
    workNumbers[r['WorkPhone']] = name
  end

  if r['WorkEmail'] != nil && r['WorkEmail'].length > 0 
    workEmails[r['WorkEmail']] = name
  end

  if r['HomeEmail'] != nil && r['HomeEmail'].length > 0 
    homeEmails[r['HomeEmail']] = name
  end
end

puts mobileNumbers
puts workNumbers
puts homeNumbers
puts workEmails
puts homeEmails
=begin
#flags, 2 = sent, 3 = received
MessageSource.all.each do |m|
  puts m.address, m.date, m.text, m.country, m.flags
end

ABPerson.all.each do |p|
  puts p.First, p.Last
end

=end


Spreadsheet.open('/Users/sameersingh/Documents/Personal/Travel/CouchStatsNew.xls') do |book|
  book.worksheets.each do |sheet|
    puts sheet.name
  end
end

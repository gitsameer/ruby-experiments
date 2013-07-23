require 'sequel'
require 'logger'     
require_relative 'models/Contacts'   #loads Contacts into DB

SMS_DB = Sequel.connect('sqlite://sms.db')
AB_DB = Sequel.connect('sqlite://AddressBook.sqlitedb')     

temp_sql = "SELECT ROWID, datetime(date,'unixepoch', 'localtime')  as date, group_id, country, case flags when '2' then 'rcvd' when '3' then 'sent' else flags end as type, address, text from message"

dataset = SMS_DB[temp_sql]

dataset.each_with_index do | row, i |      
                             
  #exit if i > 2    
  
        Messages.create(:ROWID => row[:ROWID],
                   :date  => row[:date], 
                   :group_id => row[:group_id],
                   :country   => row[:country],
                   :type      => row[:type],
                   :address   => row[:address],
                   :text      => row[:text]
  )

end
   
=begin

Messages.create(:ROWID => row[:ROWID],
                 :date  => row[:Date], 
                 :group_id => row[:Group_id],
                 :country   => row[:Country],
                 :type      => row[:Type],
                 :address   => row[:Address],
                 :text      => row[:Text]
)

=end

      
                                 
                                 
                            


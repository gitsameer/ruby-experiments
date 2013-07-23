require 'sequel'
require 'logger'     
require_relative 'models/CS'   #loads Contacts into DB

SMS_DB = Sequel.connect('sqlite://sms-2.db')
AB_DB = Sequel.connect('sqlite://AddressBook.sqlitedb')     

temp_sql = "SELECT ROWID, datetime(date,'unixepoch', 'localtime')  as date, group_id, country, case flags when '2' then 'rcvd' when '3' then 'sent' else flags end as type, address, text from message"

dataset = SMS_DB[temp_sql]

dataset.each_with_index do | row, i |      
                             
  #exit if i > 2               
        rowid = 20000 +  row[:ROWID]    
        groupid = 20000 + row[:group_id]
                    
        normalizedphone = row[:address]
        if row[:address] != nil 
           normalizedphone = row[:address].gsub(/\.0$/,"").gsub(/[^0-9+]/, "")     
        end
                          
        curMessage = Messages[:ROWID=>rowid]    
        
        if curMessage != nil then    
          curMessage.group_id = groupid
          curMessage.save();
        else 
          puts "inserting " + rowid.to_s + " " + row[:text].to_s
        Messages.create(:ROWID => rowid,
                   :date  => row[:date], 
                   :group_id => groupid,
                   :country   => row[:country],
                   :type      => row[:type],
                   :address   => row[:address],
                   :text      => row[:text],
                   :normalizedphone => normalizedphone
  )                             
end

end


      
                                 
                                 
                            


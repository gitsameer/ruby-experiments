require 'sequel'
require 'logger'     
require_relative 'models/CS'   #loads Contacts into DB

SMS_DB = Sequel.connect('sqlite://sms.db')
AB_DB = Sequel.connect('sqlite://AddressBook.sqlitedb')     

temp_sql = "SELECT ROWID, address from message"

dataset = SMS_DB[temp_sql]

dataset.each_with_index do | row, i |      
                             
  #exit if i > 2     
        next if row[:address] == nil
        
        puts "processing address => " + row[:address]
  
        normalized_address =  row[:address].gsub(/\.0$/,"").gsub(/[^0-9+]/, "")    
                                                     

        curMessage = Messages[:ROWID => row[:ROWID]]  
        
  
        if (curMessage != nil )     
           puts "Saving " + normalized_address
           curMessage.normalizedphone = normalized_address
           curMessage.save()
        end

end

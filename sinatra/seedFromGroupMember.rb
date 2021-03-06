require 'sequel'
require 'logger'     
require_relative 'models/CS'   #loads Contacts into DB

SMS_DB = Sequel.connect('sqlite://sms-3.db')
AB_DB = Sequel.connect('sqlite://AddressBook.sqlitedb')     

temp_sql = "SELECT address, group_id, country from group_member"

dataset = SMS_DB[temp_sql]

dataset.each_with_index do | row, i |      
                             
  #exit if i > 2             
  groupid = 30000 + row[:group_id]  
  
  curphone = row[:address].gsub(/\.0$/,"").gsub(/[^0-9+]/, "")    
  
  puts "updating " + curphone    
  curContact = ContactsByPhone[:normalizedphone=>curphone]   
  
  #puts "got contact = " + curContact.inspect
                     
  if (curContact != nil)   
     ##puts "updating"
    curContact.country =  row[:country]  
    curContact.group_id = groupid   
    curContact.save()     
  else 
    ContactsByPhone.create(:normalizedphone=>curphone, :country=>row[:country], :group_id=>groupid)
  end                       
  
                 
end


      
                                 
                                 
                            


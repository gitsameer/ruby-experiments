require 'sequel'
require 'logger'
require_relative 'models/CS'

#DB.logger = Logger.new($stdout)

##### Begin Queries here       
     
     
     
#### example 2. to find contact from a normalized phone
contact = Contacts.find(:id => ContactsByPhone.find(:normalizedphone => '+905305227201').contacts_id)
puts contact.inspect  
#puts contact[:contacts_id] 
      
#### example 3. to get conversations for a group_id    

dataset = Messages.filter(:group_id => 10)
puts dataset.all.count 
dataset.each do |c| 
   puts c[:type].to_s +  " : " + c[:text].to_s
end         

 

exit


                                                           

#### example 1. to filter contacts
dataset = DB[:contacts].filter(:current => true).order_by(Sequel.desc(:age),Sequel.desc(:rating))  
#puts dataset.all.count

dataset.each do |c|
   puts c[:csid] + ' ' + c[:rating].to_s  + ' ' +  c[:age].to_s + ' ' +  c[:phone].to_s +  c[:notes].to_s
end

require 'sequel'
require 'logger'
require_relative 'models/CS'

#DB.logger = Logger.new($stdout)

if ARGV.length < 1
  puts "Usage queryMsgsFL <first> <last>"        
end

first = ARGV[0].strip 

if ARGV.length ==2    
  last = ARGV[1].strip     
else 
  last = nil
end


###### 1. Find a contact by first & last name and get the phone number

contact = Contacts.find(:firstname => first, :lastname => last)
puts "got contact = " + contact.inspect
          
if contact != nil       
 puts "got phone => " + contact.phone.to_s    
 
 abort("no phone number found") if contact.phone == nil
 
 phone = contact.phone.gsub(/\.0$/,"").gsub(/[^0-9+]/, "")   
 
 puts "normalized phone => " + phone    
 
 
 ###### 2. Normalize the phone number and look in ContactsByPhone to get a GroupID
 
 contactbyphone = ContactsByPhone.find(:normalizedphone => phone)  
 
 puts "got contact by phone " + contactbyphone.inspect
           
 ##### 3. find messages by group id & phone number
 if (contactbyphone != nil && contactbyphone.group_id != nil)   
      puts "Messages using group id =>"
      dataset = Messages.filter(:group_id => contactbyphone.group_id) 
      dataset.each do |c|      
         type = c[:type]
         if type == 'sent'
           type = '>>>'
         else
           type = '<<<'
         end  
         
         puts c[:date].strftime("%m/%d/%Y %I:%M%p") + " " + type + " : " + c[:text].to_s
      end        
 end                                                  
 
 ##### 4. find messages by phone number
 
 if (contactbyphone != nil && contactbyphone.group_id == nil)    
   puts "Messages using phone number =>"
   dataset = Messages.filter(:normalizedphone => phone) 
   dataset.each do |c|  
     type = c[:type]
      if type == 'sent'
        type = '>>>'
      else
        type = '<<<'     
        
      end
      puts c[:date].strftime("%m/%d/%Y %I:%M%p") + " " + type +  " : " + c[:text].to_s
   end    
 end
end

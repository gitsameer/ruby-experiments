require 'sequel'
require 'logger'     
require_relative 'models/CS'   #loads Contacts into DB
                                 
#DB.logger = Logger.new($stdout) 
                                       
                              
# here we load all normal phones, home phones and work phones into the ContactByPhone table
                            
Contacts.each do |c|
   #puts c[:id].to_s + ' ' + c[:phone].to_s  + ' ' +  c[:homephone].to_s + ' ' +  c[:workphone].to_s 
  
   curphone = c[:phone].to_s.gsub(/\.0$/,"").gsub(/[^0-9+]/, "")     
    #puts "found => " + contactbyphone.find(:normalizedphone => curphone).to_s    
   
   if curphone.length > 0 && !ContactsByPhone.find(:normalizedphone => curphone) 
     puts "inserting " + curphone
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])   
   end
   
   curphone = c[:homephone].to_s.gsub(/\.0$/,"").gsub(/[^0-9+]/, "")   
   if curphone.length > 0 && !ContactsByPhone.find(:normalizedphone => curphone)  
      puts "inserting " + curphone
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])  
   end
  
   curphone = c[:workphone].to_s.gsub(/\.0$/,"").gsub(/[^0-9+]/, "")   
   if curphone.length> 0 && !ContactsByPhone.find(:normalizedphone => curphone) 
      puts "inserting " + curphone
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])  
   end 
   
end

require 'sequel'
require 'logger'     
require_relative 'models/Contacts'   #loads Contacts into DB
                                 
#DB.logger = Logger.new($stdout) 
                              
Contacts.each do |c|
   #puts c[:id].to_s + ' ' + c[:phone].to_s  + ' ' +  c[:homephone].to_s + ' ' +  c[:workphone].to_s 
  
   curphone = c[:phone].to_s.gsub(/[^0-9+]/, "")     
    #puts "found => " + contactbyphone.find(:normalizedphone => curphone).to_s 
   
   if !ContactsByPhone.find(:normalizedphone => curphone) 
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])   
   end
   
   curphone = c[:homephone].to_s.gsub(/[^0-9+]/, "")   
   if !ContactsByPhone.find(:normalizedphone => curphone)
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])  
   end
  
   curphone = c[:workphone].to_s.gsub(/[^0-9+]/, "")   
   if !ContactsByPhone.find(:normalizedphone => curphone)
     ContactsByPhone.create(:normalizedphone  =>curphone,:contacts_id => c[:id])  
   end 
   
end

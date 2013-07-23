require 'sequel'
require 'logger'     
require_relative 'models/CS'   #loads Contacts into DB

SMS_DB = Sequel.connect('sqlite://sms-3.db')
AB_DB = Sequel.connect('sqlite://AddressBook-3.sqlitedb')

temp_sql = "select ABPerson.ROWID, ABPerson.prefix, ABPerson.first,ABPerson.last, c.value as MobilePhone, h.value as HomePhone, he.value as HomeEmail, w.value as WorkPhone, we.value as WorkEmail from ABPerson left outer join ABMultiValue c on c.record_id = ABPerson.ROWID and c.label = 1 and c.property= 3 left outer join ABMultiValue h on h.record_id = ABPerson.ROWID and h.label = 2 and h.property = 3 left outer join ABMultiValue he on he.record_id = ABPerson.ROWID and he.label = 2 and he.property = 4 left outer join ABMultiValue w on w.record_id = ABPerson.ROWID and w.label = 4 and w.property = 3 left outer join ABMultiValue we on we.record_id = ABPerson.ROWID and we.label = 4 and we.property = 4"

dataset = AB_DB[temp_sql]

dataset.each do | row |      
                                
  rid = "3" + row[:ROWID].to_s                          
  if (Contacts.find(:firstname => row[:First],:lastname => row[:Last]))   
    #puts "will skip"
  else 
     puts "adding " + row[:First].to_s + " " + row[:Last].to_s 
     Contacts.create(:csid        => rid,
                        :firstname   => row[:First], 
                        :lastname    => row[:Last], 
                        :phone       => row[:MobilePhone],     
                        :age         => "",
                        :rating      => "",
                        :notes       => "",
                        :type        => "ab",
                        :current     => false,
                        :homephone   => row[:HomePhone], 
                        :workphone   => row[:WorkPhone],
                        :email       => row[:WorkEmail]   
                        )
  end
  
  

end
=begin   

         Contacts.create(:csid        => row[:ROWID],
                           :firstname   => row[:First], 
                           :lastname    => row[:Last], 
                           :phone       => row[:MobilePhone],     
                           :age         => "",
                           :rating      => "",
                           :notes       => "",
                           :type        => "ab",
                           :current     => false,
                           :homephone   => row[:HomePhone], 
                           :workphone   => row[:WorkPhone],
                           :email       => row[:WorkEmail]   
                           )
      
                                 
                                 
                                 
dataset.each do |row|
 if row[:MobilePhone].to_s.length > 0 && row[:HomePhone].to_s.length > 0 
   p row.inspect
 end 

 if row[:WorkPhone].to_s.length > 0 && row[:HomePhone].to_s.length > 0 
   p row.inspect
 end 

 if row[:MobilePhone].to_s.length > 0 && row[:WorkPhone].to_s.length > 0 
   p row.inspect
 end 
end

=end

#ds2 = dataset.to_hash(:MobilePhone, :First)
#p ds2
 


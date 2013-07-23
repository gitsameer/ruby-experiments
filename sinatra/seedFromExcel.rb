require 'spreadsheet'
require 'sequel'    
require 'logger'
require_relative 'models/Contacts'
                               


#DB = Sequel.connect('sqlite://cs.db')      

#DB.logger = Logger.new($stdout)
               
=begin
class Sequel::Model
  def before_create
    self.created ||= Time.now 
    self.updated ||= Time.now 
    super
  end
end

class Contacts <  Sequel::Model(:contacts)

end            
=end

            
ContactList = []   
startRow = 0   
current = false 
Spreadsheet.open('/Users/sameersingh/Documents/Personal/Travel/CouchStatsNew.xls') do |book|
    book.worksheet("Moscow").each_with_index do |row, i|        
                       
        next if i < startRow   
        
        next if row[0].to_s.empty?       
        
        next if Contacts.find(:csid => row[0])
        
                                      
        if i >= 48
          current = true
        end 
        
                           
           
           puts "Creating #{i} : #{row[0]}" 
           ContactList << Contacts.create(:csid        => row[0],
                                          :firstname   => row[2], 
                                          :lastname    => row[3], 
                                          :phone       => row[4],     
                                          :age         => row[5],
                                          :rating      => row[6],
                                          :notes       => row[7],
                                          :city        => "Moscow",
                                          :country     => "Russia",
                                          :type        => "cs",
                                          :current     => current
                                          )
    end
end




 
 
=begin                                                   

String :csid
String :firstname
String :lastname  
Integer :age
String :email
String :phone
Text   :notes
String :type
Integer :rating
String :city
String :country
DateTime :created
DateTime :updated  
=end

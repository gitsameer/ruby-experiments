require 'spreadsheet'
require 'sequel'

DB = Sequel.connect('sqlite://cs.db')
               
class Sequel::Model
  def before_create
    self.created ||= Time.now
    super
  end
end

class Contacts <  Sequel::Model(:contacts)

end

Contacts.create(:csid => 'csid1', 
                :firstname => 'first', 
                :lastname => 'last', 
                :age => 10)
 
 
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
DB = Sequel.connect('sqlite://cs.db')  

class Contacts <  Sequel::Model(:contacts)
  def before_create
    self.created ||= Time.now
    self.updated ||= Time.now
    super
  end   
end 
  
 class ContactsByPhone <  Sequel::Model(:contactbyphone)
end    


class Messages <  Sequel::Model(:messages)
  def before_create
    self.created ||= Time.now
    self.updated ||= Time.now
    super
  end   
end


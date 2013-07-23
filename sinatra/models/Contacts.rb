DB = Sequel.connect('sqlite://cs.db')  

class Contacts <  Sequel::Model(:contacts)
  def before_create
    self.created ||= Time.now
    self.updated ||= Time.now
    super
  end

end

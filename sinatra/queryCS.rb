require 'sequel'
require 'logger'

DB = Sequel.connect('sqlite://cs.db')

#DB.logger = Logger.new($stdout)

##### Begin Queries here

dataset = DB[:contacts].filter(:current => true).order_by(Sequel.desc(:age),Sequel.desc(:rating))  
#puts dataset.all.count

dataset.each do |c|
   puts c[:csid] + ' ' + c[:rating].to_s  + ' ' +  c[:age].to_s + ' ' +  c[:phone].to_s +  c[:notes].to_s
end
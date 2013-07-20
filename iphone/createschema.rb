require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
   :adapter   => 'sqlite3',
   :database  => 'mergedcontacts.db'
)

ActiveRecord::Migration.class_eval do
  create_table :users do |t|
        t.belongs_to :place
        t.string  :first
        t.string  :last
        t.string  :phone
        t.integer :rating
   end

   create_table :messages do |t|
        t.belongs_to :user
        t.text :body
   end

   create_table :places do |t|
        t.string :name
   end

end

class User < ActiveRecord::Base
belongs_to :place 
has_many :messages
end

class Place < ActiveRecord::Base
has_many :users
end

class Message < ActiveRecord::Base
belongs_to :user
end


c1 = Place.create(:name => 'Mumbai')

puts c1.id

p1 =  User.create(:first => 'First', :last => 'Last', :phone => '555-1313', :rating=> 9, :place_id => c1.id)

m1 = Message.create(:user_id => p1.id, :body=> 'message 1')
p1.messages.create(:body => 'message 1')
p1.messages.create(:body => 'message 2')



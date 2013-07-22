require 'rubygems'
require 'sinatra'
require "sequel"
require 'logger'   
require 'json'

$logger = Logger.new(STDOUT)

DB = Sequel.connect('sqlite://test.db')

class Message < Sequel::Model(:Message)   
 
def to_json(*a)
  {
    'body' => self.body
  }.to_json(*a)
end
end

#puts Message.all.inspect
#puts Message[3] 
helpers do  
    include Rack::Utils  
    alias_method :h, :escape_html  
end
           

get '/' do
  'Hello Message Server'   
  @messages = Message.all
  # @notes = Note.all :.order => :id.desc  
  @title = 'All Messages '
  erb :index
end

get '/message/:id' do
   puts "in get **** number = #{params[:id]}"
   @message = Message[params[:id]]     
   if @message.nil? then
      status 404
   else 
      status 200
      body(@message.to_json)
   end
end

post '/message' do  
   puts "in post"
   m = Message.new
   m.body = params[:body]
   #m.created_at = Time.now
   #m.updated_at = Time.now     
   m.save            
   puts "in post redirecting to #{m.Id}"
   redirect "/message/#{m.Id}"  
end 

put '/message/:id' do      
   puts "in put"
   m = Message[params[:id]] 
   if m.nil? then 
      status 400    
   else
      m.body = params[:body]
     #m.created_at = Time.now
     #m.updated_at = Time.now     
     m.save            
     puts "in put redirecting to #{m.Id}"
     redirect "/message/#{m.Id}"  
   end
end                                          
            
get '/message' do   
   puts "in get2"
   erb:messageform  
end

not_found do  
  halt 404, 'page not found'  
end    

before do
  puts '[Params]'
  p params
end

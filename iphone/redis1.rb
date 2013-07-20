require 'rubygems'
require 'redis'
r = Redis.new
r.delete('first_key') #clear it out, if it happens to be set
puts 'Set the key {first_key} to {hello world}'
r['first_key'] = 'hello world'
puts 'The value of {first_key} is:'
puts r['first_key']

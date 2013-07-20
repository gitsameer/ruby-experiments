require 'rubygems'
require 'mechanize'


a = Mechanize.new
a.follow_meta_refresh = true
a.user_agent_alias = 'Mac Safari'
a.redirect_ok = true
a.get('http://couchsurfing.org/n/login') do |page|
  # Click the login link
  #login_page = a.click(page.link_with(:text => /Log In/))

  # Submit the login form
  my_page = page.form_with(:action => '/n/auth') do |f|
    f.username  = 'samsingh'
    f.password  = 'B0lacouchsurfing'
  end.submit

 
  #main_page = a.get('/n/places/san-francisco-california-united-states')

  list_page = a.get('https://www.couchsurfing.org/search/in/city/6769313/mode/L/age/24to/gender/female/filter/has_photo')
binding.pry

  #list_page.links_with(:href => /profile.html/).each do |link|
   list_page.links.each do |link|
    text = link
    #link.match(/id=([^&]+)&/)[1]
    #next unless text.length > 0
    puts text
  end
end

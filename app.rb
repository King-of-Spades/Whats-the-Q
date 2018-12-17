require 'json'
require 'sinatra'
require 'net/http'
require 'intercom'
require 'dotenv/load'


$intercom = Intercom::Client.new(token: ENV['TOKEN'])
$all_convos = $intercom.counts.for_type(type: 'conversation').conversation["open"]
p $all_convos

get '/' do
	p "Hi! #{$all_convos}"
end

post '/' do
	text = "{\"canvas\":{\"content_url\":\"https://frozen-badlands-35106.herokuapp.com/live_canvas\",\"stored_data\":{}}}"
 # 	text.to_json
	# p text
end

post '/live_canvas' do
  content_type 'application/json'
		
$all_convos = $intercom.counts.for_type(type: 'conversation').conversation["open"]

	text = "{\"canvas\":{\"content\":{\"components\":[{\"id\":\"ab1c31592d25779a24e25b2e97b4\",\"type\":\"text\",\"text\":\"There are currently #{$all_convos} conversations in queue.\",\"style\":\"header\",\"align\":\"left\",\"bottom_margin\":false},}]},\"stored_data\":{}}}"
 	text.to_json
	text
end
 
 
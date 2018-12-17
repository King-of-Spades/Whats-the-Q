require 'json'
require 'sinatra'
require 'net/http'
require 'intercom'
require 'dotenv/load'


$intercom = Intercom::Client.new(token: ENV['TOKEN'])
$all_convos = $intercom.counts.for_type(type: 'conversation').conversation["open"]
p $all_convos

$time = Time.now.strftime("%H:%M")
$zone = Time.now.getlocal.zone

get '/' do
	p "Hi! #{$all_convos}"
end

post '/' do
	text = "{\"canvas\":{\"content_url\":\"https://frozen-badlands-35106.herokuapp.com/live_canvas\"}}"
 	text.to_json
	text
end

post '/live_canvas' do
  content_type 'application/json'
	$response = "Current ongoing conversations: *#{$all_convos}*\\n
	Updated at: *#{$time}* *#{$zone}*"
  $all_convos = $intercom.counts.for_type(type: 'conversation').conversation["open"]
  if $all_convos == 0
  	$response = "Woot woot! On-call inbox is empty! 😎 \\n
  	Updated at: *#{$time}* *#{$zone}*"
  end
  if $all_convos >= 10
  	$response = "Current ongoing conversations: *#{$all_convos}*\\n
  	Response time might be a bit longer 😅\\n
	Updated at: *#{$time}* *#{$zone}*"
end


	text = "{\"content\":{\"components\":[{\"id\":\"ab1c31592d25779a24e25b2e97b4\",\"type\":\"text\",\"text\":\"#{$response}\",\"style\":\"header\",\"align\":\"left\",\"bottom_margin\":false}]}}"
 	text.to_json
	text


end
 
 
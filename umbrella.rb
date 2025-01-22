# Write your soltuion here!
require "dotenv/load"
require "http"
require "json"

# TIP: don't use gets first, start with hard coding the location

# Getting Location Longitude and Latitude
pp "Where is your current location?"
address = "millenium park"
gmaps_key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address="+address+"&key="+gmaps_key
raw_location_response = HTTP.get(gmaps_url)
parsed_location_response = JSON.parse(raw_location_response)
location = parsed_location_response.fetch("results").at(0).fetch("geometry").fetch("location")
latitude = location["lat"]
longitude = location["lng"]


# Get the weather at the user’s coordinates from the Pirate Weather API.

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_key + "/#{latitude},#{longitude}"
raw_weather_response = HTTP.get(pirate_weather_url)
parsed_weather_response = JSON.parse(raw_weather_response)
current_temp = parsed_weather_response.fetch("currently").fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."

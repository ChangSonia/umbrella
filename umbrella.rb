# Write your soltuion here!
require "dotenv/load"
require "http"
require "json"

# TIP: don't use gets first, start with hard coding the location

pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")

# getting google longitude and latitude
pp "Where is your current location?"
address = gets
key = ENV.fetch("GMAPS_KEY")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address="+address+"&key="+gmaps_key
raw_location_response = HTTP.get(gmaps_url)

parsed_location_response = JSON.parse(raw_location_response)

pp parsed_location_response

# Write your soltuion here!
require "dotenv/load"
require "http"
require "json"

# TIP: don't use gets first, start with hard coding the location

# Getting Location Longitude and Latitude

pp "Where is your current location?"
address = gets
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
hourly_summary = parsed_weather_response.fetch("hourly").fetch("data").at(0).fetch("summary")
future_data = parsed_weather_response.fetch("hourly").fetch("data")

# Display the current temperature and summary of the weather for the next hour.

pp "The current temperature is " + current_temp.to_s + "."
pp "Next hour is going to be " + hourly_summary.downcase + "."


# Get a list of future temperature forecast
forecast = Hash.new
will_rain = 0
hour = 0

future_data.take(12).each do |hourly_data|
  hour += 1
  precip_probability = hourly_data.fetch("precipProbability")
  if precip_probability > 0.1
    will_rain += 1
    pp "#{hour} hours from now the precipitation probability is #{precip_probability}"
  end
end

if will_rain > 0 
  pp "You might want to carry an umbrella!"
else
  pp "You probably won't need an umbrella today."
end

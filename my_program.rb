require "open-uri"
require "json"
# p "Where are you located?"
user_location = "Chicago"

#Get location using Gmaps API
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"
gmaps_raw = URI.open(gmaps_url).read
parsed = JSON.parse(gmaps_raw)
results_array = parsed.fetch("results")
only_result = results_array.at(0)
geometry = only_result.fetch("geometry")
location = geometry.fetch("location")

#Now we have lat and long for weather
lat = location.fetch("lat")
lng = location.fetch("lng")

#Send location to Dark Sky
dark_sky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/" + lat.to_s + "," + lng.to_s
ds_raw = URI.open(dark_sky_url).read
parsed_ds = JSON.parse(ds_raw)
currently = parsed_ds.fetch("currently")
temperature_now = currently.fetch("temperature")

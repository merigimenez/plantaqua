require 'open-uri'
require 'json'

class WeatherService
  def initialize(garden)
    @garden = garden
  end

  def call
    # MeriG key
    open_weather_key = "9ecc68eecaa943a0e48fd9675ea56236"
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@garden.latitude}&lon=#{@garden.longitude}&appid=#{open_weather_key}"
    # response_timezone = JSON.parse(URI.open(url).read)
    # shift = response_timezone["timezone"]
    # puts shift
    # yesterday = Date.today - 1
    # time_start = (Time.new(yesterday.year, yesterday.month, yesterday.day, 2, 0, 0, "UTC") + shift).to_i
    # time_end = (Time.new(Date.today.year, Date.today.month, Date.today.day, 2, 0, 0, "UTC") + shift).to_i
    # historic_url = "https://history.openweathermap.org/data/2.5/history/city?lat=#{@garden.latitude}&lon=#{@garden.longitude}&type=hour&start=#{time_start}&end=#{time_end}&appid=#{open_weather_key}"
    response = JSON.parse(URI.open(url).read)
    weather = response["weather"][0]["main"]
    puts weather == "Rain"
    return weather == "Rain"
  end
end

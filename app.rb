# frozen_string_literal: true

require "bundler/setup"
require 'sinatra'
require 'sinatra/content_for'
require 'tilt/erubis'
# require 'dotenv/load'
require 'net/http'
require 'geocoder'

configure(:development) do
  require 'sinatra/reloader'
  also_reload('lib/*.rb')
  # set :session_secret, ENV['SESSION_SECRET']
end

configure(:production) do
  enable :sessions
end

COMPASS_ROWS = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'NWN', 'NW', 'NNW']

helpers do
  def fetch_coordinates(location)
    coors = Geocoder.search(location).first.coordinates
  end

  def fetch_current_weather(location)
    coor = fetch_coordinates(location)
    uri = URI("https://api.openweathermap.org/data/2.5/weather?lat=#{coor.first}&lon=#{coor.last}&appid=cfacbe42176fb8d0183e611dda57ff25&units=imperial")
    JSON.parse Net::HTTP.get(uri).gsub('=>', ':')
  end

  def wind_direction(degrees)
    count = 0
    while degrees > 22.5
      degrees -= 22.5
      count += 1
    end

    COMPASS_ROWS[count]
  end
end

get '/' do
  redirect to('/search')
end

get '/search' do
  erb :search, layout: :layout
end

get '/info' do
  location = params[:location]
  if location.empty?
    session[:input_error] = "you have to enter a location to search!"
    redirect to('/search')
  end

  @info = fetch_current_weather(location)
  @time = Time.new
  erb :info, layout: :layout
end

not_found do
  session[:oops] = "you entered an invalid url!"
  redirect to('/search')
end

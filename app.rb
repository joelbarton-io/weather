# frozen_string_literal: true

require 'sinatra'
require "sinatra/content_for"
require 'tilt/erubis'
require 'dotenv/load'
require 'erubis'
require 'net/http'
require 'geocoder'

configure(:development) do
  require 'sinatra/reloader'
  also_reload('lib/*.rb')
  enable :sessions
  # set :session_secret, ENV['SESSION_SECRET']
end

helpers do
  def fetch_coordinates(location)
    coors = Geocoder.search(location).first.coordinates
  end

  def fetch_current_weather(location)
    coor = fetch_coordinates(location)
    uri = URI("https://api.openweathermap.org/data/2.5/weather?lat=#{coor.first}&lon=#{coor.last}&appid=cfacbe42176fb8d0183e611dda57ff25&units=imperial")
    JSON.parse Net::HTTP.get(uri).gsub('=>', ':')
  end
end

get '/weather' do
  erb :weather, layout: :layout
end

get '/info' do
  location = params[:location]
  @info = fetch_current_weather(location)
  erb :info, layout: :layout
end

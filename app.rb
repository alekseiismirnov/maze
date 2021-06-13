# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

also_reload 'lib/**/*.rb'

get '/' do
  redirect to '/static/1'
end

get '/favicon.ico' do
  redirect to '/public/favicon.ico'
end

get '/static/:id' do
  erb :"static#{params[:id]}"
end

get '/rooms/:id' do
  room = Room.find params[:id].to_i
  @room_hash = room.to_hash
  erb :room
end

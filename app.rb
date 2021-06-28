# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

also_reload 'lib/**/*.rb'

get '/' do
  room = Room.new("This is the Enterance.\n Just created")
  room.save
  redirect to "/rooms/#{room.id}"
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

get '/rooms/:id/new' do
  @id = params[:id].to_i
  erb :room_new
end

post '/rooms/:id' do
  ancestor_id = params[:id].to_i
  description = params[:description]
  room = Room.new(description, [ancestor_id])
  room.save

  ancestor = Room.find ancestor_id
  doors = ancestor.doors + [room.id]
  ancestor.update(doors: doors)

  redirect to "/rooms/#{room.id}"
end

get '/rooms/:id/edit' do
  id = params[:id].to_i
  @room_hash = Room.find(id).to_hash

  erb :room_edit
end

patch '/rooms/:id' do
  id = params[:id].to_i
  description = params[:description]
  room = Room.find id
  room.update description

  redirect to "/rooms/#{room.id}"
end

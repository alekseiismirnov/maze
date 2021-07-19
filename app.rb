# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/room'
require './lib/item'

also_reload 'lib/**/*.rb'

get '/start' do
  Room.clear
  room = Room.new("This is the Enterance.\n Just created")
  room.save

  Item.clear
  nail = Item.new(type: 'nail', detail: 'A rusty nail')
  nail.save

  room.put_item(nail)

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
  @items = room.item_ids.map { |id| Item.find(id).to_hash }

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
  room.update(description: description)

  redirect to "/rooms/#{room.id}"
end

delete '/rooms/:id' do
  id = params[:id].to_i
  room = Room.find id
  rooms_connected = room.doors

  room.delete

  rooms_connected.each do |door|
    room = Room.find door
    doors_updated = room.doors.clone
    doors_updated.delete id
    room.update(doors: doors_updated)
  end

  ancestor_id = rooms_connected.min # ids are sequentially grow

  redirect to "/rooms/#{ancestor_id}"
end

get '/items/:id' do
  id = params[:id].to_i
  @item = Item.find(id).to_hash

  erb :item
end

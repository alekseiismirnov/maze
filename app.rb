# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

also_reload 'lib/**/*.rb'

get '/' do
  redirect to '/static/1'
end

get '/static/:id' do
  erb :"static#{params[:id]}"
end

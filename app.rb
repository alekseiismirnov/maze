# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

also_reload 'lib/**/*.rb'

get '/' do
  'Hello there!'
end

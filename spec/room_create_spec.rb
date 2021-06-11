# frozen_string_literal: true

require 'capybara/rspec'
require './app'

require 'room'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Room', type: :feature) do
  context 'with default constructor' do
    before :each do
      @empty_room = Room.new
    end

    it 's description is nil' do
      expect(@empty_room.description).to be nil
    end

    it 'has no doors' do
      expect(@empty_room.doors).to eq []
    end
  end

  context 'with parametric costructor' do
    before :each do
      @description = 'Kind of a room.'
      @doors = [3, 1, 24]
      @room = Room.new(@description, @doors)
    end

    it 'has a description' do
      expect(@room.description).to eq @description
    end

    it 'has a rooms` list' do
      expect(@room.doors).to eq @doors
    end
  end
end

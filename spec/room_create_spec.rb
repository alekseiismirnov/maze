# frozen_string_literal: true

require 'capybara/rspec'
require './app'

require 'room'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Room creation', type: :feature) do
  context 'room with default constructor' do
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
end

# frozen_string_literal: true

require 'capybara/rspec'
require './app'

require 'room'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe(Room, type: :feature) do
  context 'if no rooms saved' do
    before :each do
      Room.clean
    end

    it 'called .all returns empty list' do
      expect(Room.all).to eq []
    end
  end

  context 'if there is a saved room' do
    before :each do
      @description = 'Some description'
      @doors = [2,3,4,5]
      @saved_room = Room.new(@description, @doors)
      @saved_room.save
    end

    it 'on .all returns list with length 1' do
      expect(Room.all.length).to eq 1
    end

    it 'is possible to .find it' do
      room = Room.find @saved_room.id
      expect(room.description).to eq @saved_room.description
      expect(room.doors).to eq @saved_room.doors
    end

    it 'is possible to update description' do
      new_description = 'Compleately different room'
      @saved_room.update(description: new_description)
      room = Room.find @saved_room.id
      expect(room.description).to eq new_description
    end

    it 'is possible to update doors list' do
      updated_doors = @saved_room.doors.clone << 100_500
      @saved_room.update(doors: updated_doors)
      room = Room.find @saved_room.id
      expect(room.doors).to eq updated_doors
    end
  end
end

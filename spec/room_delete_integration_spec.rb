# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp/'

describe('Room#delete', type: :feature) do
  context 'delete room with `delete` button' do
    before :each do
      @enterance = Room.new('The Enterance')
      @enterance.save
      @room = Room.new('Room to demolish', [@enterance.id])
      @room.save
      @room_id = @room.id
      @enterance.update(doors: [@room.id])
      visit "/rooms/#{@room.id}"
      click_on 'Delete'
    end

    it 'deletes the room from `database`' do
      expect(Room.find(@room.id)).to eq nil
    end

    it 'removes doors to it from the neighbours' do
      visit "/rooms/#{@enterance.id}"
      expect(page).not_to have_content("Door ##{@room_id}\n")
    end
  end
end

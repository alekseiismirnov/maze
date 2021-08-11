# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'room'

Capybara.app = Sinatra::Application
set(show_exceptions: false)

Capybara.save_path = '~/tmp'

# #add_lever(lever_id, door_id, position) position - number 0-9
# initial value always 0
# #set_lever(lever_id, position)
#
# #levers_ids

describe('Levers', type: :feature) do
  before :each do
    @doors = [50, 10, 13, 24, 98]

    Room.clear
    @hall = Room.new 'This is a hall with many doors'
    @hall.save

    @hall.update(doors: @doors)
  end

  context 'There is no levers' do
    it 'list of avaiable doors is same as the list of all doors' do
      expect(@hall.doors.sort).to eq @hall.all_doors.sort
    end
  end

  context 'There is a lever' do
    before :each do
      @lever_id = 1
      @levered_door_id = @doors.sample
      @open_position = (1..9).to_a.sample

      @hall.add_lever(@levered_door_id, @open_position)
    end

    it 'there is no correspondent door on the page' do
      visit "/rooms/#{@hall.id}"

      within '.doors' do
        expect(page).to have_no_content("Door ##{@levered_door_id}")
      end
    end
  end
end
